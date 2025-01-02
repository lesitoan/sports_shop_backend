const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const insertAddressService = async (userId, payload) => {
    try {
        const { fullName, phoneNumber, province, district, ward, addressDetail } = payload;
        if (!fullName || !phoneNumber || !province || !district || !ward || !addressDetail) {
            throw new AppError('missing required field', 400);
        }
        const query = `INSERT INTO addresses (userId, fullName, phoneNumber, province, district, ward, addressDetail) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        const response = await pool.query(query, [
            userId,
            fullName,
            phoneNumber,
            province,
            district,
            ward,
            addressDetail,
        ]);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllAddressesService = async (userId) => {
    try {
        const query = `SELECT * FROM addresses WHERE userId = ?`;
        const response = await pool.query(query, [userId]);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const deleteAddressByIdService = async (userId, addressId) => {
    try {
        const query = `DELETE FROM addresses WHERE id = ? AND userId = ?`;
        const response = await pool.query(query, [addressId, userId]);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertAddressService,
    getAllAddressesService,
    deleteAddressByIdService,
};
