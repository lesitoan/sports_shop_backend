const {
    insertCategoryService,
    getAllCategoriesService,
    deleteCategoryByIdService,
} = require('../services/categoryServices');
const AppError = require('../utils/AppError');

const insertCategory = async (req, res, next) => {
    try {
        const result = await insertCategoryService(req.body);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert category failed', 400));
        }
        return res.status(201).json({
            status: 'success',
            message: 'Insert category success',
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

const getAllCategories = async (req, res, next) => {
    try {
        const categories = await getAllCategoriesService();
        res.status(200).json({
            status: 'success',
            count: categories.length,
            data: {
                categories,
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

const deleteCategoryById = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const result = await deleteCategoryByIdService(id);
        if (result.affectedRows === 0) {
            return next(new AppError('Delete category failed', 400));
        }
        return res.status(200).json({
            status: 'success',
            message: 'Delete category success',
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
    insertCategory,
    getAllCategories,
    deleteCategoryById,
};
