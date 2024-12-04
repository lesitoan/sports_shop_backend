const express = require('express');
const { getAllUsers, deleteUserById } = require('../controllers/userController');

const router = express.Router();
router.route('/').get(getAllUsers);
router.route('/:id').delete(deleteUserById);

module.exports = router;
