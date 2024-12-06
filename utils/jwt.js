const jwt = require('jsonwebtoken');
const AppError = require('./AppError');

const generateToken = async (data, key, expiresIn) => {
    if (!data) return null;
    return new Promise((resolve, reject) =>
        jwt.sign(data, key, { expiresIn }, (err, token) => {
            if (err) {
                console.log(err.message);
                reject(new AppError('Login failed', 400));
            } else {
                resolve(token);
            }
        }),
    );
};

const verifyToken = async (token, key) => {
    if (!token) return null;
    return new Promise((resolve, reject) =>
        jwt.verify(token, key, (err, decoded) => {
            if (err) {
                console.log(err.message);
                if (err.name === 'TokenExpiredError') {
                    reject(new AppError('Token expired', 401));
                } else {
                    reject(new AppError('Token invalid', 401));
                }
            } else {
                resolve(decoded);
            }
        }),
    );
};

module.exports = {
    generateToken,
    verifyToken,
};
