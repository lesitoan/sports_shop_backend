const express = require('express');
const { deleteBrandById, getAllBrands, insertBrand } = require('../controllers/brandController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getAllBrands).post(insertBrand);
router.delete('/:id', deleteBrandById);

module.exports = router;
