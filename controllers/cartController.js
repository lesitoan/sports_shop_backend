const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const insertCart = async (req, res, next) => {
    try {
        return res.status(201).json({
            status: 'success',
            message: 'Insert cart success',
            data: null,
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

const getAllCarts = async (req, res, next) => {
    try {
        res.status(200).json({
            status: 'success',
            count: 0,
            data: {},
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

const deleteCartById = async (req, res, next) => {
    try {
        return res.status(200).json({
            status: 'success',
            message: 'Delete cart success',
            data: null,
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

module.exports = {
    insertCart,
    getAllCarts,
    deleteCartById,
};
