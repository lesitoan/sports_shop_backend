const {
    createOrderService,
    getAllOrdersService,
    getOrderByIdService,
    deleteOrderByIdService,
} = require('../services/orderServices');

const createOrder = async (req, res, next) => {
    try {
        const result = await createOrderService(req.user.id, req.body);
        return res.status(201).json({
            status: 'success',
            message: 'Create order success',
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
            orders,
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
            order,
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

const deleteOrderById = async (req, res, next) => {
    try {
        await deleteOrderByIdService(req.user.id, req.params.id);
        return res.status(200).json({
            status: 'success',
            message: 'Delete order success',
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
    createOrder,
    getAllOrder,
    getOrderById,
    deleteOrderById,
};
