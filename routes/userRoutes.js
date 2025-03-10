const express = require('express');
const { getAllUsers, deleteUserById } = require('../controllers/userController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getAllUsers);
router.route('/:id').delete(deleteUserById);

module.exports = router;
