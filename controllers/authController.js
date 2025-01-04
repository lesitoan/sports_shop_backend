const AppError = require('../utils/AppError');
const {
    signUpService,
    signInService,
    resetPasswordService,
    updatePasswordService,
    saveRefreshTokenDBService,
    refreshTokenService,
    deleteRefreshTokenDBService,
    getMeService,
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

        // Create cookie
        const cookieOptions = {
            maxAge: 2 * 24 * 60 * 60 * 1000, // 2 days
            httpOnly: true, // không cho phép client thay đổi cookie
            secure: false,
        };
        res.cookie('accessToken', accessToken, cookieOptions);
        res.cookie('refreshToken', refreshToken, cookieOptions);

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
        await updatePasswordService(req.user, req.body);
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

const getMe = async (req, res, next) => {
    try {
        const user = await getMeService(req.user.id);
        res.status(200).json({
            status: 'success',
            message: 'Get me success',
            data: { user },
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
        const refreshToken = req.cookies?.refreshToken;
        if (!refreshToken) {
            return next(new AppError('Unauthorized', 401));
        }
        const accessToken = await refreshTokenService(refreshToken);

        // Create cookie
        const cookieOptions = {
            maxAge: 2 * 24 * 60 * 60 * 1000, // 2 days
            httpOnly: true, // không cho phép client thay đổi cookie
            secure: false,
        };
        res.cookie('accessToken', accessToken, cookieOptions);

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

const logout = async (req, res, next) => {
    try {
        // delete refresh token in db
        const result = await deleteRefreshTokenDBService(req.user.id);
        if (result.affectedRows === 0) {
            return next(new AppError('Logout failed', 400));
        }

        // delete cookie
        res.clearCookie('accessToken');
        res.clearCookie('refreshToken');

        res.status(200).json({
            status: 'success',
            message: 'Logout success',
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
    signUp,
    signIn,
    resetPassword,
    updatePassword,
    getMe,
    refreshToken,
    logout,
};
