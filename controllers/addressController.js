const {
    deleteAddressByIdService,
    getAllAddressesService,
    insertAddressService,
} = require('../services/addressServices');
const AppError = require('../utils/AppError');

const insertAddress = async (req, res, next) => {
    try {
        const result = await insertAddressService(req.user.id, req.body);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert address failed', 400));
        }
        return res.status(201).json({
            status: 'success',
            message: 'Insert address success',
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

const getAllAddresses = async (req, res, next) => {
    try {
        const addresses = await getAllAddressesService(req.user.id);
        res.status(200).json({
            status: 'success',
            count: addresses.length,
            addresses,
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

const deleteAddressById = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const result = await deleteAddressByIdService(req.user.id, id);
        if (result.affectedRows === 0) {
            return next(new AppError('Delete address failed', 400));
        }
        return res.status(200).json({
            status: 'success',
            message: 'Delete address success',
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
    insertAddress,
    getAllAddresses,
    deleteAddressById,
};
