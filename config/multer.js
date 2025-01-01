const multer = require('multer');
const AppError = require('../utils/appError');

const storage = multer.diskStorage({
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
        cb(null, file.fieldname + '-' + uniqueSuffix);
    },
});

const upload = multer({
    storage: storage,
    fileFilter: function (req, file, cb) {
        if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png' || file.mimetype === 'image/webp') {
            cb(null, true);
        } else {
            cb(new AppError('Please upload png/ jpeg file !!!', 400));
        }
        if (file.size > 1024 * 1024 * 2) {
            cb(new AppError('Please upload image < 2MB !!!', 400));
        }
    },
});

module.exports = upload;
