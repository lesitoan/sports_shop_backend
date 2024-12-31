const express = require('express');
const { getProducts, insertProduct, getProductById } = require('../controllers/productController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getProducts).post(upload.array('images'), insertProduct);
router.route('/:id').get(getProductById);

module.exports = router;
