const express = require('express');
const { deleteAddressById, getAllAddresses, insertAddress } = require('../controllers/addressController');
const { authMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware);
router.route('/').get(getAllAddresses).post(insertAddress);
router.delete('/:id', deleteAddressById);

module.exports = router;
