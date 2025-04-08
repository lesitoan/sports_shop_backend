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
        query = `INSERT INTO orderaddresses (fullName, phoneNumber, province, district, ward, addressDetail, orderId) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        await connection.query(query, [fullName, phoneNumber, province, district, ward, addressDetail, orderId]);

        // insert order details into  orderdetails table
        const orderdetails = carts.map((cart) => {
            const attributes = JSON.stringify(cart.attributes);
            return [orderId, cart.productId, cart.quantity, cart.price, attributes];
        });
        query = `INSERT INTO  orderdetails (orderId, productId, quantity, price, attributes) VALUES ?`;
        await connection.query(query, [orderdetails]);

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
                                'fullName', orderaddresses.fullName,
                                'phoneNumber', orderaddresses.phoneNumber,
                                'province', orderaddresses.province,
                                'district', orderaddresses.district,
                                'ward', orderaddresses.ward,
                                'addressDetail', orderaddresses.addressDetail
                        )) as address,
                        JSON_ARRAYAGG( JSON_OBJECT(
                                'productId',  orderdetails.productId,
                                'productName', products.name,
                                'quantity',  orderdetails.quantity,
                                'price',  orderdetails.price,
                                'attributes',  orderdetails.attributes,
                                'imageUrls', (SELECT JSON_ARRAYAGG(url) FROM images WHERE productId =  orderdetails.productId)
                        )) as products
                        FROM orders
                        INNER JOIN orderaddresses ON orders.id = orderaddresses.orderId
                        LEFT JOIN  orderdetails ON orders.id =  orderdetails.orderId
                        LEFT JOIN products ON  orderdetails.productId = products.id
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

        let [result] = await connection.query('DELETE FROM orderaddresses WHERE orderId = ?', [orderId]);
        if (!result.affectedRows) {
            throw new AppError('can not delete this order', 400);
        }
        [result] = await connection.query('DELETE FROM  orderdetails WHERE orderId = ?', [orderId]);
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
