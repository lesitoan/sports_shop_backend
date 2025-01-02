const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const createOrderService = async (userId, payload) => {
    try {
        let { address, products, paymentStatus, paymentMethod, shippingFee, description } = payload;

        if (!address || !products || !paymentStatus || !paymentMethod) {
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
        shippingFee = shippingFee || 0;
        const price = products.reduce((total, product) => total + product.price, 0) + shippingFee;
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
        const orderDetails = products.map((product) => {
            const attributes = JSON.stringify(product.attributes);
            return [orderId, product.productId, product.quantity, product.price, attributes];
        });
        query = `INSERT INTO orderDetails (orderId, productId, quantity, price, attributes) VALUES ?`;
        await connection.query(query, [orderDetails]);

        // update shopping cart
        query = `UPDATE carts SET price = 0, quantity = 0 WHERE userId = ?`;
        await connection.query(query, [userId]);

        const cartItemIds = products.map((product) => product.cartItemId);
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

module.exports = {
    createOrderService,
};
