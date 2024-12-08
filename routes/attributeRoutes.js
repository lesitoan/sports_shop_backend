const express = require('express');
const { insertAttributes, getAllAttributes, deleteAttributeById } = require('../controllers/attributeController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getAllAttributes).post(insertAttributes);
router.delete('/:id', deleteAttributeById);

module.exports = router;
