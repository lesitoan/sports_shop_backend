const express = require('express');
const { getAllClubOrNations, insertClubOrNation, deleteClubById } = require('../controllers/clubOrNationalController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').get(getAllClubOrNations).post(insertClubOrNation);
router.delete('/:id', deleteClubById);

module.exports = router;
