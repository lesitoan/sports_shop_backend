const { createOrderService, getAllOrdersService, getOrderByIdService } = require('../services/orderServices');

const createOrder = async (req, res, next) => {
    try {
        const result = await createOrderService(req.user.id, req.body);
        return res.status(201).json({
            status: 'success',
            message: 'Create order success',
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

const getAllOrder = async (req, res, next) => {
    try {
        const orders = await getAllOrdersService(req.user.id);
        return res.status(200).json({
            status: 'success',
            count: orders.length,
            data: { orders },
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

const getOrderById = async (req, res, next) => {
    try {
        const order = await getOrderByIdService(req.user.id, req.params.id);
        return res.status(200).json({
            status: 'success',
            data: { order },
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
    createOrder,
    getAllOrder,
    getOrderById,
};
