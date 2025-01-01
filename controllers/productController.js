const { insertProductService } = require('../services/productServices');
const AppError = require('../utils/AppError');

const getAllProducts = async (req, res) => {
    try {
        console.log(results);
        console.log(fields);
        res.send('Get all products !');
    } catch (err) {
        console.log(err);
    }
};

const insertProduct = async (req, res, next) => {
    try {
        // const result = await insertProductService(req.body);
        // if (result.affectedRows === 0) {
        //     return next(new AppError('Insert product failed', 400));
        // }
        console.log(req.body);
        console.log(req.file);
        return res.status(201).json({
            status: 'success',
            message: 'Insert product success',
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
    getAllProducts,
    insertProduct,
};
