const pool = require('../config/connectDB');
const createSlug = require('../utils/createSlug');

const insertProductService = async (payload) => {
    try {
        const { name, price, quantity, categoryId, brandId, clubOrNationalId, image } = payload;
        if (!name || !price || !quantity || !categoryId || !image || image.length === 0) {
            throw new Error('Missing required fields');
        }
        const slug = createSlug(name);
        const query = `INSERT INTO products (name,slug, price, quantity, categoryId, brandId, clubOrNationalId) VALUES
                        ('${name}', '${slug}', ${price}, ${quantity}, ${categoryId}, ${brandId || null}, ${
            clubOrNationalId || null
        })`;
        const response = await pool.query(query, payload);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertProductService,
};
