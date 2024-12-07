const { getAllUsersService, deleteUserByIdService } = require('../services/userServices');
const AppError = require('../utils/AppError');

const getAllUsers = async (req, res, next) => {
    try {
        const users = await getAllUsersService(req.query);
        res.status(200).json({
            status: 'success',
            count: users.length,
            data: {
                users,
            },
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

const deleteUserById = async (req, res, next) => {
    try {
        const id = req.params.id;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const result = await deleteUserByIdService(id);
        if (result.affectedRows === 0) {
            return next(new AppError('No user found with that ID', 404));
        }
        res.status(204).json({
            status: 'success',
            message: 'delete user success',
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
    getAllUsers,
    deleteUserById,
};
