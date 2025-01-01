const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const insertAttributeService = async (payload) => {
    try {
        let query = `INSERT IGNORE INTO attributes (attrName, attrValue) VALUES ?`;
        const attributes = payload.map((item) => [item.attrName, item.attrValue]);
        const response = await pool.query(query, [attributes]);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllAttributesService = async (filter) => {
    try {
        const { attrName } = filter;
        let query = `SELECT * FROM attributes`;
        if (attrName) {
            query += ` WHERE attrName = '${attrName}'`;
        }
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const deleteAttributeByIdService = async (id) => {
    try {
        const response = await pool.query(`DELETE FROM attributes WHERE id = ${id}`);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertAttributeService,
    getAllAttributesService,
    deleteAttributeByIdService,
};
