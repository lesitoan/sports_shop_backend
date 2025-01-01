const express = require('express');
const { getProducts, insertProduct, getProductById } = require('../controllers/productController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.route('/').get(getProducts);
router.route('/:id').get(getProductById);

router.use(authMiddleware, adminMiddleware);
router.post('/', upload.array('images'), insertProduct);

module.exports = router;
