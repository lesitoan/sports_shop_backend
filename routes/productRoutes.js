const express = require('express');
const { getProducts, insertProduct, getProductBySlug } = require('../controllers/productController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.route('/').get(getProducts);
router.route('/:slug').get(getProductBySlug);

router.use(authMiddleware, adminMiddleware);
router.post('/', upload.array('images'), insertProduct);

module.exports = router;
