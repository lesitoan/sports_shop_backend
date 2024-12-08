const {
    getAllClubsService,
    insertClubOrNationalService,
    deleteClubByIdService,
} = require('../services/clubOrNationalService');
const AppError = require('../utils/AppError');

const insertClubOrNation = async (req, res, next) => {
    try {
        const result = await insertClubOrNationalService(req.body);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert club failed', 400));
        }
        return res.status(201).json({
            status: 'success',
            message: 'Insert club success',
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

const getAllClubOrNations = async (req, res, next) => {
    try {
        const clubs = await getAllClubsService(req.query);
        res.status(200).json({
            status: 'success',
            count: clubs.length,
            data: {
                clubs,
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

const deleteClubById = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const result = await deleteClubByIdService(id);
        if (result.affectedRows === 0) {
            return next(new AppError('Delete club failed', 400));
        }
        return res.status(200).json({
            status: 'success',
            message: 'Delete club success',
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
    insertClubOrNation,
    getAllClubOrNations,
    deleteClubById,
};
