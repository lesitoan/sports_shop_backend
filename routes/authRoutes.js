const express = require('express');
const {
    signUp,
    signIn,
    resetPassword,
    updatePassword,
    refreshToken,
    logout,
    getMe,
} = require('../controllers/authController');
const { authMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();
router.post('/signup', signUp);
router.post('/signin', signIn);
router.patch('/reset-password', resetPassword);
router.post('/refresh-token', refreshToken);

router.patch('/update-password', authMiddleware, updatePassword);
router.get('/logout', authMiddleware, logout);
router.get('/me', authMiddleware, getMe);

module.exports = router;
