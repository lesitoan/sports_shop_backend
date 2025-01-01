const express = require('express');
const { getAllCategories, insertCategory, deleteCategoryById } = require('../controllers/categoryController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.route('/').get(getAllCategories);

router.use(authMiddleware, adminMiddleware);
router.post('/', insertCategory);
router.delete('/:id', deleteCategoryById);

module.exports = router;
