const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');
const createSlug = require('../utils/createSlug');

const insertBrandService = async (payload) => {
    try {
        const { name } = payload;
        if (!name) {
            throw new AppError('brand name is required', 400);
        }
        const slug = createSlug(name);
        const query = `INSERT INTO brands (name, slug) VALUES ('${name}', '${slug}')`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllBrandsService = async () => {
    try {
        const query = `SELECT * FROM brands`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const deleteBrandsByIdService = async (id) => {
    try {
        const query = `DELETE FROM brands WHERE id = ${id}`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertBrandService,
    getAllBrandsService,
    deleteBrandsByIdService,
};
