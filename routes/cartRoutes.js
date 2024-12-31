const express = require('express');
const { deleteCartById, getAllCarts, insertCart } = require('../controllers/cartController');
const { authMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware);
router.route('/').get(getAllCarts).post(insertCart);
router.delete('/:id', deleteCartById);

module.exports = router;
