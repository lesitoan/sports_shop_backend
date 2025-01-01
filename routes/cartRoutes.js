const express = require('express');
const { deleteCartById, getAllCarts, insertCart, updateCartById } = require('../controllers/cartController');
const { authMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware);
router.route('/').get(getAllCarts).post(insertCart);
router.route('/:id').delete(deleteCartById).patch(updateCartById);

module.exports = router;
