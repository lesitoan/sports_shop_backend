const AppError = require('../utils/appError');
const {
    signUpService,
    signInService,
    resetPasswordService,
    updatePasswordService,
    saveRefreshTokenDBService,
    refreshTokenService,
} = require('../services/authServices');
const { generateToken } = require('../utils/jwt');

const signUp = async (req, res, next) => {
    try {
        const result = await signUpService(req.body);
        if (result.affectedRows === 0) {
            return next(new AppError('Create user faild', 404));
        }
        res.status(201).json({
            status: 'success',
            message: 'sign up success',
            data: null,
        });
    } catch (error) {
        console.log(error);
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

const signIn = async (req, res, next) => {
    try {
        const user = await signInService(req.body);
        const { id, userName, role } = user;
        // create access token
        const accessToken = await generateToken(
            { id, userName, role },
            process.env.JWT_SECRET,
            process.env.ACCESS_TOKEN_EXPIRES_IN,
        );

        const refreshToken = await generateToken(
            { id, userName, role },
            process.env.JWT_SECRET,
            process.env.REFRESH_TOKEN_EXPIRES_IN,
        );
        const response = await saveRefreshTokenDBService(refreshToken, id);
        if (!response) {
            return next(new AppError('Login failed', 400));
        }

        res.status(200).json({
            status: 'success',
            message: 'sign in success',
            data: { user, accessToken, refreshToken },
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

const resetPassword = async (req, res, next) => {
    try {
        const newPassword = await resetPasswordService(req.body);
        const { email } = req.body;

        res.status(200).json({
            status: 'success',
            message: 'Reset password success',
            data: { newPassword },
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

const updatePassword = async (req, res, next) => {
    try {
        await updatePasswordService(req.body);
        res.status(200).json({
            status: 'success',
            message: 'Change password success',
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

const refreshToken = async (req, res, next) => {
    try {
        const accessToken = await refreshTokenService(req.body);
        res.status(200).json({
            status: 'success',
            message: 'Refresh token success',
            data: { accessToken },
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
    signUp,
    signIn,
    resetPassword,
    updatePassword,
    refreshToken,
};
