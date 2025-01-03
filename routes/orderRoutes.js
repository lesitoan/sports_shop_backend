const express = require('express');
const { createOrder, getAllOrder, getOrderById, deleteOrderById } = require('../controllers/orderController');
const { authMiddleware } = require('../middleware/authMiddleware');
const upload = require('../config/multer');

const router = express.Router();

router.use(authMiddleware);
router.route('/').get(getAllOrder).post(createOrder);
router.route('/:id').get(getOrderById).delete(deleteOrderById);

module.exports = router;
