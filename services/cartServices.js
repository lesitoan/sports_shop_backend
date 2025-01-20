const AppError = require('../utils/AppError');
const pool = require('../config/connectDB');

const insertCartService = async (user, payload) => {
    try {
        const userId = user.id;
        let { quantity, price, productId, productAttributeIds } = payload;
        if (!quantity || !productId || !userId) {
            throw new AppError('quantity, price, productId are required', 400);
        }

        const connection = await pool.getConnection();
        await connection.beginTransaction();

        // insert table cartItems
        const [cart] = await connection.query('SELECT * FROM carts WHERE userId = ?', [userId]);
        const cartData = cart[0];
        if (!cartData) {
            throw new AppError('Error, plesea try again', 400);
        }
        const response1 = await connection.query(
            'INSERT INTO cartItems (quantity, price, productId, cartId) VALUES (?, ?, ?, ?)',
            [quantity, price, productId, cartData?.id],
        );
        const cartItemId = response1[0].insertId;
        // insert table cartItemAttributes
        if (productAttributeIds.length > 0 && typeof productAttributeIds === 'string') {
            productAttributeIds = JSON.parse(productAttributeIds);
        }
        const data = productAttributeIds.map((id) => [id, cartItemId]);
        await connection.query('INSERT INTO cartItemAttributes (productAttributeId, cartItemId) VALUES ?', [data]);

        // update table carts
        const newPrice = cartData.price + Number(price);
        const newQuantity = cartData.quantity + 1;

        await connection.query('UPDATE carts SET quantity = ?, price = ? WHERE id = ?', [
            newQuantity,
            newPrice,
            cartData.id,
        ]);

        connection.commit();
    } catch (error) {
        throw error;
    }
};

const getAllCartsService = async (userId) => {
    try {
        const query = `SELECT
                            cartItems.id as cartItemId,cartItems.quantity, cartItems.price,
                            products.name as productName, products.id as productId,
                            JSON_ARRAYAGG(images.url) as imageUrls,
                            JSON_ARRAYAGG( JSON_OBJECT(
                                'attrName', attributes.attrName,
                                'attrValue', attributes.attrValue
                            )) AS attributes
                        FROM cartItems
                        LEFT JOIN products ON cartItems.productId = products.id
                        LEFT JOIN images ON products.id = images.productId
                        LEFT JOIN cartItemAttributes ON cartItems.id = cartItemAttributes.cartItemId
                        LEFT JOIN productAttributes ON cartItemAttributes.productAttributeId = productAttributes.id
                        LEFT JOIN attributes ON productAttributes.attributeId = attributes.id
                        WHERE cartItems.cartId = (SELECT id FROM carts WHERE userId = ?)
                        GROUP BY cartItems.id`;
        const [carts] = await pool.query(query, [userId]);

        //modify data
        if (carts.length > 0) {
            carts.forEach((cart) => {
                if (cart.imageUrls[0] === null) {
                    cart.imageUrls = null;
                } else {
                    cart.imageUrls = [...new Set(cart.imageUrls)];
                }
                if (cart.attributes[0].attrName === null) {
                    cart.attributes = null;
                } else {
                    cart.attributes = Array.from(new Set(cart.attributes.map((item) => JSON.stringify(item)))).map(
                        (item) => JSON.parse(item),
                    );
                }
            });
        }
        return carts;
    } catch (error) {
        throw error;
    }
};

const deleteCartByIdService = async (userId, cartItemId) => {
    try {
        const connection = await pool.getConnection();
        await connection.beginTransaction();
        // delete cartItemAttribute
        await connection.query('DELETE FROM cartItemAttributes WHERE cartItemId = ?', [cartItemId]);
        // delete cartItem
        const [cartItem] = await connection.query('SELECT * FROM cartItems WHERE id = ?', [cartItemId]);
        if (cartItem.length === 0) {
            throw new AppError('Cart not found', 404);
        }
        await connection.query('DELETE FROM cartItems WHERE id = ?', [cartItemId]);
        // update cart
        const price = cartItem[0].price;
        const response = await connection.query(
            'UPDATE carts SET quantity = quantity - 1, price = price - ? WHERE userId = ?',
            [price, userId],
        );
        connection.commit();
        return response;
    } catch (error) {
        throw error;
    }
};

const updateCartService = async (userId, cartItemId, payload) => {
    try {
        const { quantity } = payload;
        if (!quantity) {
            throw new AppError('quantity is required', 400);
        }
        const [cartItem] = await pool.query('SELECT * FROM cartItems WHERE id = ?', [cartItemId]);
        if (cartItem.length === 0) {
            throw new AppError('Cart not found', 404);
        }
        const connection = await pool.getConnection();
        await connection.beginTransaction();

        const oldPrice = cartItem[0].price;
        const oldQuantity = cartItem[0].quantity;
        const newPrice = (oldPrice / oldQuantity) * quantity;

        await connection.query('UPDATE cartItems SET quantity = ?, price = ? WHERE id = ?', [
            quantity,
            newPrice,
            cartItemId,
        ]);
        const response = await connection.query('UPDATE carts SET price = price - ? + ? WHERE userId = ?', [
            oldPrice,
            newPrice,
            userId,
        ]);
        connection.commit();
        return response;
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertCartService,
    getAllCartsService,
    deleteCartByIdService,
    updateCartService,
};
