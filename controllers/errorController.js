const globalErrorHandler = (error, req, res, next) => {
    let statusCode = error.statusCode || 500;
    let message = error.message || 'server error !!!!';
    let status = error.status || 'error';

    //handle sql error
    if (error.code === 'ER_BAD_FIELD_ERROR') {
        //Tham chiếu đến một cột không tồn tại
        statusCode = 400;
        status = 'fail';
        message = 'Invalid field';
    } else if (error.code === 'ER_DUP_ENTRY') {
        //Tham chiếu đến một cột mà nó duy nhất
        statusCode = 400;
        status = 'fail';
        message = 'Duplicate field';
    } else if (error.code === 'ER_PARSE_ERROR') {
        //Lỗi cú pháp SQL
        statusCode = 400;
        status = 'fail';
        message = 'Parse error';
    }

    res.status(statusCode).json({
        status,
        message,
    });
};

module.exports = globalErrorHandler;
