const pool = require('../config/connectDB');
const AppError = require('../utils/appError');
const createSlug = require('../utils/createSlug');

const insertProductService = async (data, imageUrls) => {
    try {
        const { name, price, quantity, categoryId, brandId, clubOrNationalId } = data;
        if (!name || !price || !quantity || !categoryId) {
            throw new AppError('Missing required fields', 400);
        }
        const slug = createSlug(name);
        const query = `INSERT INTO products (name,slug, price, quantity, categoryId, brandId, clubOrNationalId) VALUES
                        ('${name}', '${slug}', ${price}, ${quantity}, ${categoryId}, ${brandId || null}, ${
            clubOrNationalId || null
        })`;
        let response = await pool.query(query, data);
        if (response[0].affectedRows === 0) {
            return next(new AppError('Insert product failed', 400));
        }
        //insert images
        if (imageUrls && imageUrls.length > 0) {
            const productId = response[0].insertId;
            const images = imageUrls.map((item) => `('${item}', ${productId})`);
            const queryImages = `INSERT INTO images (url, productId) VALUES ${images.join(',')}`;
            response = await pool.query(queryImages);
        }
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertProductService,
};
