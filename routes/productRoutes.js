const express = require('express');
const path = require('path');

const { getAllProducts, insertProduct } = require('../controllers/productController');
const multer = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

const router = express.Router();
router.route('/').get(getAllProducts).post(upload.single('images'), insertProduct);

module.exports = router;
