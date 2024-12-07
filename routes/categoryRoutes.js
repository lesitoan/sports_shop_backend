const express = require('express');
const { getAllCategories, insertCategory, deleteCategoryById } = require('../controllers/categoryController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getAllCategories).post(insertCategory);
router.delete('/:id', deleteCategoryById);

module.exports = router;
