const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const { hashPassword, verifyPassword } = require('../utils/bcrypt');
const { validateEmail, validatePassword, validateUserName } = require('../utils/validation');
const { verifyToken, generateToken } = require('../utils/jwt');
const sendMail = require('../utils/sendMail');

const signUpService = async (payload) => {
    try {
        const { userName, email, password, passwordConfirm } = payload;
        if (!userName || !email || !password || !passwordConfirm) {
            throw new AppError('Registration information is incomplete', 400);
        }
        if (password !== passwordConfirm) {
            throw new AppError('Password and password confirm do not match', 400);
        }
        if (!validateEmail(email)) {
            throw new AppError('Email is invalid', 400);
        }
        if (!validatePassword(password)) {
            throw new AppError('The password is not in the correct format or does not have enough 8 characters', 400);
        }
        if (!validateUserName(userName)) {
            throw new AppError('userName only includes a-z, A-Z, 0-9 and 5 characters or more', 400);
        }
        const hashedPassword = await hashPassword(password);

        const connection = await pool.getConnection();
        await connection.beginTransaction(); // start transaction
        const query = `INSERT INTO users (userName, email, userPw) VALUES ('${userName}', '${email}', '${hashedPassword}')`;

        // create cart for user
        const response = await connection.query(query);
        if (response[0].affectedRows !== 0) {
            await connection.query(
                `INSERT INTO carts (userId, quantity, price) VALUES (${response[0].insertId}, 0, 0)`,
            );
        }
        await connection.commit(); // commit transaction

        return response[0];
    } catch (error) {
        throw error;
    }
};

const signInService = async (payload) => {
    try {
        const { userName, email, password } = payload;
        let response;
        if (email && password && validateEmail(email)) {
            response = await pool.query(`SELECT * FROM users WHERE email = '${email}'`);
        } else if (userName && password && validateUserName(userName)) {
            response = await pool.query(`SELECT * FROM users WHERE userName = '${userName}'`);
        } else {
            throw new AppError('Login failed', 400);
        }
        const user = response[0][0];
        if (!user) {
            throw new AppError('Login failed', 400);
        }
        const isPasswordMatch = await verifyPassword(password, user.userPw);
        if (!isPasswordMatch) {
            throw new AppError('Login failed', 400);
        }
        user.userPw = null;
        return user;
    } catch (error) {
        throw error;
    }
};

const resetPasswordService = async (payload) => {
    try {
        const { userName, email } = payload;
        if (!userName || !email) {
            throw new AppError('Reset password failed', 400);
        }
        const user = (
            await pool.query(`SELECT * FROM users WHERE userName = '${userName}' AND email = '${email}'`)
        )[0][0];
        if (!user) {
            throw new AppError('Reset password failed', 400);
        }
        const newPassword = `toandeptrai_${Math.floor(Math.random() * 10000000)}`;

        //send mail
        const isSendMail = await sendMail(email, 'Reset password', `Your new password is: ${newPassword}`);
        if (!isSendMail) {
            throw new AppError('Reset password failed', 400);
        }
        const hashedPassword = await hashPassword(newPassword);
        const query = `UPDATE users SET userPw = '${hashedPassword}' WHERE userName = '${userName}' AND email = '${email}'`;
        const response = await pool.query(query);
        if (response[0].affectedRows === 0) {
            throw new AppError('Reset password failed', 400);
        }
        return newPassword;
    } catch (error) {
        throw error;
    }
};

const updatePasswordService = async (userData, payload) => {
    try {
        console.log('userData', userData);
        const { oldPassword, newPassword, newPasswordConfirm } = payload;
        if (!userData || !oldPassword || !newPassword || !newPasswordConfirm) {
            throw new AppError('Change password failed', 400);
        }
        if (newPassword !== newPasswordConfirm) {
            throw new AppError('Password and password confirm do not match', 400);
        }
        if (!validatePassword(newPassword)) {
            throw new AppError('The password is not in the correct format or does not have enough 8 characters', 400);
        }
        const user = (await pool.query(`SELECT * FROM users WHERE id = '${userData.id}'`))[0][0];
        if (!user) {
            throw new AppError('Change password failed', 400);
        }
        const isPasswordMatch = await verifyPassword(oldPassword, user.userPw);
        if (!isPasswordMatch) {
            throw new AppError('Password is incorrect', 400);
        }
        const hashedPassword = await hashPassword(newPassword);
        const query = `UPDATE users SET userPw = '${hashedPassword}' WHERE id = '${userData.id}'`;
        const response = await pool.query(query);
        if (response[0].affectedRows === 0) {
            throw new AppError('Change password failed', 400);
        }
        return null;
    } catch (error) {
        throw error;
    }
};

const saveRefreshTokenDBService = async (refreshToken, userId) => {
    try {
        const currentRow = (await pool.query(`SELECT * FROM userValidations WHERE userId = '${userId}'`))[0][0];
        // save refreshToken to database
        console.log('userId', userId);
        console.log('currentRow', currentRow);
        let res;
        if (currentRow) {
            res = await pool.query(
                `UPDATE userValidations SET refreshToken = '${refreshToken}' WHERE userId = '${userId}'`,
            );
            if (res[0].affectedRows === 0) {
                return null;
            }
        } else {
            res = await pool.query(
                `INSERT INTO userValidations (refreshToken, userId) VALUES ('${refreshToken}', ${userId})`,
            );
            if (res[0].affectedRows === 0) {
                return null;
            }
        }
        return res[0];
    } catch (error) {
        throw error;
    }
};

const refreshTokenService = async (payload) => {
    try {
        const { refreshToken } = payload;
        console.log('refreshToken', refreshToken);
        if (!refreshToken) {
            throw new AppError('Refresh token failed', 400);
        }
        const userValidation = (
            await pool.query(`SELECT * FROM userValidations WHERE refreshToken = '${refreshToken}'`)
        )[0][0];
        if (!userValidation) {
            throw new AppError('Refresh token failed', 400);
        }
        const decoded = await verifyToken(refreshToken, process.env.JWT_SECRET);
        const accessToken = await generateToken(
            { id: decoded.id, userName: decoded.userName, role: decoded.role },
            process.env.JWT_SECRET,
            process.env.ACCESS_TOKEN_EXPIRES_IN,
        );
        return accessToken;
    } catch (error) {
        throw error;
    }
};

module.exports = {
    signUpService,
    signInService,
    resetPasswordService,
    updatePasswordService,
    saveRefreshTokenDBService,
    refreshTokenService,
};
