const express = require('express');
const { getAllProducts, insertProduct } = require('../controllers/productController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getAllProducts).post(upload.array('images'), insertProduct);

module.exports = router;
