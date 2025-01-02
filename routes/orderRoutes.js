const express = require('express');
const { createOrder, getAllOrder, getOrderById } = require('../controllers/orderController');
const { authMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.use(authMiddleware);
router.route('/:id').get(getOrderById);
router.route('/').get(getAllOrder).post(createOrder);

module.exports = router;
