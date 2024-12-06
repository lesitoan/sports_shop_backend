const express = require('express');
const { signUp, signIn, resetPassword, updatePassword, refreshToken } = require('../controllers/authController');

const router = express.Router();
router.post('/signup', signUp);
router.post('/signin', signIn);
router.post('/refresh-token', refreshToken);
router.patch('/reset-password', resetPassword);
router.patch('/update-password', updatePassword);

module.exports = router;
