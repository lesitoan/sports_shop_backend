const { deleteBrandsByIdService, getAllBrandsService, insertBrandService } = require('../services/brandServices');
const AppError = require('../utils/AppError');

const insertBrand = async (req, res, next) => {
    try {
        const result = await insertBrandService(req.body);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert brand failed', 400));
        }
        return res.status(201).json({
            status: 'success',
            message: 'Insert brand success',
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

const getAllBrands = async (req, res, next) => {
    try {
        const brands = await getAllBrandsService();
        res.status(200).json({
            status: 'success',
            count: brands.length,
            data: {
                brands,
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

const deleteBrandById = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const result = await deleteBrandsByIdService(id);
        if (result.affectedRows === 0) {
            return next(new AppError('Delete brand failed', 400));
        }
        return res.status(200).json({
            status: 'success',
            message: 'Delete brand success',
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
    insertBrand,
    getAllBrands,
    deleteBrandById,
};
