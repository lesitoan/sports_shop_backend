const AppError = require('../utils/AppError');
const { verifyToken } = require('../utils/jwt');

const authMiddleware = async (req, res, next) => {
    try {
        let token = '';
        if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
            token = req.headers.authorization.split(' ')[1];
        }
        if (!token) {
            throw new AppError('Unauthorized', 401);
        }
        const decoded = await verifyToken(token, process.env.JWT_SECRET);
        req.user = {
            id: decoded.id,
            username: decoded.username,
            role: decoded.role,
        };
        return next();
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

const adminMiddleware = (req, res, next) => {
    if (req.user.role !== 'admin') {
        return next(new AppError('Forbidden', 403));
    }
    return next();
};

module.exports = {
    authMiddleware,
    adminMiddleware,
};
