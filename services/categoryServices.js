const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');
const createSlug = require('../utils/createSlug');

const insertCategoryService = async (payload) => {
    try {
        const { name } = payload;
        if (!name) {
            throw new AppError('Category name is required', 400);
        }
        const slug = createSlug(name);
        const category = await pool.query(`SELECT * FROM categories WHERE slug = '${slug}'`);
        if (category[0].length > 0) {
            throw new AppError('Category already exists', 409);
        }
        const query = `INSERT INTO categories (name, slug) VALUES ('${name}', '${slug}')`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllCategoriesService = async () => {
    try {
        const query = `SELECT * FROM categories`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const deleteCategoryByIdService = async (id) => {
    try {
        const query = `DELETE FROM categories WHERE id = ${id}`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertCategoryService,
    getAllCategoriesService,
    deleteCategoryByIdService,
};
