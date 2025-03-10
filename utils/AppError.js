class AppError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.statusCode = statusCode || 500;
        this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
        // Error.captureStackTrace(this, this.constructor); //Điều này giúp làm sáng tỏ nơi lỗi xảy ra trong mã nguồn khi bạn xem stack trace
    }
}

module.exports = AppError;
