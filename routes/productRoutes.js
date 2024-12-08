const express = require('express');
const { getAllProducts, insertProduct } = require('../controllers/productController');

const router = express.Router();
router.route('/').get(getAllProducts).post(insertProduct);

module.exports = router;
