const express = require('express');
const { createOrder } = require('../controllers/orderController');
const { authMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.use(authMiddleware);
// router.route('/').get(getProducts);
// router.route('/:id').get(getProductById);
router.post('/', createOrder);

module.exports = router;
