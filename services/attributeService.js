const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const insertAttributeService = async (payload) => {
    try {
        let { data } = payload;
        let query = `INSERT IGNORE INTO attributes (attrName, attrValue, price) VALUES`;
        data.forEach((item, index) => {
            if (item.attrName && item.attrValue && index === data.length - 1) {
                query += ` ('${item.attrName}', '${item.attrValue}', ${item.price || 0});`;
            } else if (item.attrName && item.attrValue) {
                query += ` ('${item.attrName}', '${item.attrValue}', ${item.price || 0}),`;
            }
        });
        const response = await pool.query(query);
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
