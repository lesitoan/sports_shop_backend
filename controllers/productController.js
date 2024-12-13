const { insertProductService } = require('../services/productServices');
const AppError = require('../utils/appError');
const uploadCloudinary = require('../config/cloudinary');

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
        // Upload an image
        console.log(req.files);
        console.log(req.body);

        const uploadResult = await uploadCloudinary(req.files);
        if (!uploadResult || uploadResult.length === 0) {
            throw new AppError('Upload image failed', 400);
        }
        const imageUrls = uploadResult.map((item) => item.url);

        const result = await insertProductService(req.body, imageUrls);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert product failed', 400));
        }

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
