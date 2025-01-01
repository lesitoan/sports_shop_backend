const {
    insertAttributeService,
    getAllAttributesService,
    deleteAttributeByIdService,
} = require('../services/attributeService');
const AppError = require('../utils/AppError');

const insertAttributes = async (req, res, next) => {
    try {
        const result = await insertAttributeService(req.body.attributes);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert attributes failed', 400));
        }

        return res.status(201).json({
            status: 'success',
            message: `Insert attribute ${req.body?.attributes?.length || 0} rows, success ${result.affectedRows} rows`,
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

const getAllAttributes = async (req, res, next) => {
    try {
        const attributes = await getAllAttributesService(req.query);
        res.status(200).json({
            status: 'success',
            count: attributes.length,
            data: {
                attributes,
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

const deleteAttributeById = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const result = await deleteAttributeByIdService(id);
        if (result.affectedRows === 0) {
            return next(new AppError('Delete attribute failed', 400));
        }
        return res.status(200).json({
            status: 'success',
            message: 'Delete attribute success',
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
    insertAttributes,
    getAllAttributes,
    deleteAttributeById,
};
