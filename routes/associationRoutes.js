const express = require('express');
const {
    insertAssociation,
    getAllContinents,
    getAllLeagues,
    getClubsByLeagueId,
    getCountriesByLeagueId,
} = require('../controllers/associationController');
const { authMiddleware, adminMiddleware } = require('../middleware/authMiddleware');

const router = express.Router();

router.use(authMiddleware, adminMiddleware);
router.route('/').post(insertAssociation);
router.route('/leagues').get(getAllLeagues);
router.route('/leagues/:id').get(getClubsByLeagueId);
router.route('/continents').get(getAllContinents);
router.route('/continents/:id').get(getCountriesByLeagueId);
// router.delete('/:id', deleteClubById);

module.exports = router;
