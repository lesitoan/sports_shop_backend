const express = require('express');
const { signUp, signIn, resetPassword, updatePassword, refreshToken } = require('../controllers/authController');
const { authMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();
router.post('/signup', signUp);
router.post('/signin', signIn);
router.patch('/reset-password', resetPassword);

router.post('/refresh-token', refreshToken);
router.patch('/update-password', authMiddleware, updatePassword);

module.exports = router;
