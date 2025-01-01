const AppError = require('../utils/AppError');
const {
    insertCartService,
    getAllCartsService,
    deleteCartByIdService,
    updateCartService,
} = require('../services/cartServices');

const insertCart = async (req, res, next) => {
    try {
        await insertCartService(req.user, req.body);
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
        const carts = await getAllCartsService(req.user.id);
        res.status(200).json({
            status: 'success',
            count: carts.length,
            data: { carts },
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
        const response = await deleteCartByIdService(req.user?.id, req.params.id);
        if (response.affectedRows === 0) {
            return next(new AppError('Cart not found', 404));
        }
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

const updateCartById = async (req, res, next) => {
    try {
        const response = await updateCartService(req.user.id, req.params.id, req.body);
        if (response.affectedRows === 0) {
            return next(new AppError('Cart not found', 404));
        }
        return res.status(200).json({
            status: 'success',
            message: 'Update cart success',
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
    updateCartById,
};
