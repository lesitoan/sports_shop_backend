const globalErrorHandler = (error, req, res, next) => {
    console.log(error);
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
        //Ex: sqlMessage: "Duplicate entry 'admin' for key 'users.userName'"
        const DuplicateField = error.sqlMessage.split('for key')[1].split('.')[1].split("'")[0];
        statusCode = 400;
        status = 'fail';
        message = `Duplicate field ${DuplicateField}`;
    } else if (error.code === 'ER_PARSE_ERROR') {
        //Lỗi cú pháp SQL
        statusCode = 400;
        status = 'fail';
        message = 'Parse error';
    } else if (error.code === 'ER_ROW_IS_REFERENCED_2') {
        //không thể xóa hoặc cập nhật một hàng cha: một ràng buộc khóa ngoại thất bại
        statusCode = 400;
        status = 'fail';
        message = 'Cannot delete row, because it is being used elsewhere';
    } else if (error.code === 'WARN_DATA_TRUNCATED') {
        //dũ liệu không hợp lệ
        //  sqlMessage: "Data truncated for column 'continent' at row 1"
        const field = error.sqlMessage.split('column')[1].split('at')[0].trim();
        statusCode = 400;
        status = 'fail';
        message = `Data for ${field} is invalid`;
    } else if (error.code === 'ER_NO_REFERENCED_ROW_2') {
        //Tham chiếu đến một hàng không tồn tại
        const field = error.sqlMessage.split('FOREIGN KEY')[1].split('REFERENCES')[0].trim();
        statusCode = 400;
        status = 'fail';
        message = `referenced ${field} not found`;
    }

    res.status(statusCode).json({
        status,
        message,
    });
};

module.exports = globalErrorHandler;
