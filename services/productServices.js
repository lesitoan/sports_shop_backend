const express = require('express');
const { getAllProducts } = require('../controllers/productControllers');

const router = express.Router();
router.route('/').get(getAllProducts);

module.exports = router;
