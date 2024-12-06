const pool = require('../config/connectDB');

const getAllUsersService = async (payload) => {
    try {
        let { limit, page, sort, duration } = payload;
        let query = 'SELECT id, userName, email, phoneNumber, createAt FROM users';
        if (duration) {
            duration = Number(duration) || 30; // default 30 days
            const today = new Date();
            const prevDay = new Date(new Date().setDate(today.getDate() - duration)).toISOString();
            query += ` WHERE createAt >= '${prevDay}'`;
        }
        if (sort) {
            query += ` ORDER BY ${sort}`;
        }
        if (limit) {
            page = Number(page) || 1;
            console.log(page);
            query += ` LIMIT ${limit} OFFSET ${limit * (page - 1)}`;
        }

        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const deleteUserByIdService = async (id) => {
    try {
        const query = `DELETE FROM users WHERE id = ${id}`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    getAllUsersService,
    deleteUserByIdService,
};
