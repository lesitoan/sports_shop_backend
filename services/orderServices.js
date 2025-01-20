const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');
const { getAllCartsService } = require('./cartServices');

const createOrderService = async (userId, payload) => {
    try {
        const carts = await getAllCartsService(userId);
        if (!carts || carts.length === 0) {
            throw new AppError('cart is empty', 400);
        }
        let { address, paymentStatus, paymentMethod, shippingFee, description } = payload;

        shippingFee = 30000;
        paymentStatus = paymentStatus || 'unpaid';
        paymentMethod = paymentMethod || 'cash';
        console.log(address, paymentStatus, paymentMethod);

        if (!address || !paymentStatus || !paymentMethod) {
            throw new AppError('missing required field', 400);
        }
        const { fullName, phoneNumber, province, district, ward, addressDetail } = address;
        if (!fullName || !phoneNumber || !province || !district || !ward || !addressDetail) {
            throw new AppError('missing required field', 400);
        }

        const connection = await pool.getConnection();
        await connection.beginTransaction(); // start transaction

        // insert order into orders table
        const orderStatus = 'pending';

        const price = carts.reduce((total, cart) => total + cart.price, 0);
        let query = `INSERT INTO orders (userId, price, paymentStatus, paymentMethod, orderStatus, shippingFee, description) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        const orderRes = await connection.query(query, [
            userId,
            price,
            paymentStatus,
            paymentMethod,
            orderStatus,
            shippingFee,
            description,
        ]);
        const orderId = orderRes[0].insertId;

        // insert address into orderAddress table
        query = `INSERT INTO orderAddresses (fullName, phoneNumber, province, district, ward, addressDetail, orderId) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        await connection.query(query, [fullName, phoneNumber, province, district, ward, addressDetail, orderId]);

        // insert order details into orderDetails table
        const orderDetails = carts.map((cart) => {
            const attributes = JSON.stringify(cart.attributes);
            return [orderId, cart.productId, cart.quantity, cart.price, attributes];
        });
        query = `INSERT INTO orderDetails (orderId, productId, quantity, price, attributes) VALUES ?`;
        await connection.query(query, [orderDetails]);

        // update shopping cart
        query = `UPDATE carts SET price = 0, quantity = 0 WHERE userId = ?`;
        await connection.query(query, [userId]);

        const cartItemIds = carts.map((cart) => cart.cartItemId);
        query = `DELETE FROM cartItemAttributes WHERE cartItemId IN (?)`;
        await connection.query(query, [cartItemIds]);
        query = `DELETE FROM cartItems WHERE id IN (?)`;
        await connection.query(query, [cartItemIds]);

        connection.commit(); // commit transaction
        return true;
    } catch (error) {
        throw error;
    }
};

const getAllOrdersService = async (userId) => {
    try {
        const query = `SELECT * FROM orders WHERE userId = ?`;
        const [orders] = await pool.query(query, [userId]);
        return orders;
    } catch (error) {
        throw error;
    }
};

const getOrderByIdService = async (userId, orderId) => {
    try {
        console.log(userId, orderId);
        const query = `SELECT orders.*,
                        JSON_ARRAYAGG( JSON_OBJECT(
                                'fullName', orderAddresses.fullName,
                                'phoneNumber', orderAddresses.phoneNumber,
                                'province', orderAddresses.province,
                                'district', orderAddresses.district,
                                'ward', orderAddresses.ward,
                                'addressDetail', orderAddresses.addressDetail
                        )) as address,
                        JSON_ARRAYAGG( JSON_OBJECT(
                                'productId', orderDetails.productId,
                                'productName', products.name,
                                'quantity', orderDetails.quantity,
                                'price', orderDetails.price,
                                'attributes', orderDetails.attributes,
                                'imageUrls', (SELECT JSON_ARRAYAGG(url) FROM images WHERE productId = orderDetails.productId)
                        )) as products
                        FROM orders
                        INNER JOIN orderAddresses ON orders.id = orderAddresses.orderId
                        LEFT JOIN orderDetails ON orders.id = orderDetails.orderId
                        LEFT JOIN products ON orderDetails.productId = products.id
                        LEFT JOIN images ON products.id = images.productId
                        WHERE orders.userId = ? AND orders.id = ?
                        GROUP BY orders.id`;
        const [orders] = await pool.query(query, [userId, orderId]);
        if (!orders.length) {
            throw new AppError('order not found', 404);
        }
        // modify data
        orders[0].address = orders[0].address[0];
        orders[0].products = Array.from(new Set(orders[0].products.map((item) => JSON.stringify(item)))).map((item) =>
            JSON.parse(item),
        );
        return orders[0];
    } catch (error) {
        throw error;
    }
};

// delete when status = pending
const deleteOrderByIdService = async (userId, orderId) => {
    try {
        const connection = await pool.getConnection();
        await connection.beginTransaction(); // start transaction

        let [result] = await connection.query('DELETE FROM orderAddresses WHERE orderId = ?', [orderId]);
        if (!result.affectedRows) {
            throw new AppError('can not delete this order', 400);
        }
        [result] = await connection.query('DELETE FROM orderDetails WHERE orderId = ?', [orderId]);
        if (!result.affectedRows) {
            throw new AppError('can not delete this order', 400);
        }
        [result] = await connection.query(
            `DELETE FROM orders WHERE userId = ? AND id = ? AND orderStatus = 'pending'`,
            [userId, orderId],
        );
        if (!result.affectedRows) {
            throw new AppError('can not delete this order', 400);
        }
        connection.commit(); // commit transaction
    } catch (error) {
        throw error;
    }
};

module.exports = {
    createOrderService,
    getAllOrdersService,
    getOrderByIdService,
    deleteOrderByIdService,
};
