const express = require('express');
const { deleteBrandById, getAllBrands, insertBrand } = require('../controllers/brandController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.route('/').get(getAllBrands);

router.use(authMiddleware, adminMiddleware);
router.post('/', insertBrand);
router.delete('/:id', deleteBrandById);

module.exports = router;
