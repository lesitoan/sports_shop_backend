const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');
const createSlug = require('../utils/createSlug');

const insertAssociationService = async (payload) => {
    try {
        let { name, type, leagueId, continentId } = payload;
        if (!name || !type || (!leagueId && !continentId)) {
            throw new AppError('Enter all required data', 400);
        }
        if (leagueId && continentId) {
            continentId = null;
        }
        const slug = createSlug(name);
        const query = `INSERT INTO productAssociations (name, slug, type, leagueId, continentId) VALUES
                        ('${name}', '${slug}', '${type}', ${leagueId || null}, ${continentId || null})`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllLeaguesService = async () => {
    try {
        const query = `SELECT * FROM leagues`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllContinentsService = async () => {
    try {
        const query = `SELECT * FROM continents`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getClubsByLeagueIdService = async (id) => {
    try {
        const query = `SELECT * FROM productAssociations WHERE leagueId = ${id}`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getCountriesByContinentIdService = async (id) => {
    try {
        const query = `SELECT * FROM productAssociations WHERE continentId = ${id}`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertAssociationService,
    getAllLeaguesService,
    getAllContinentsService,
    getClubsByLeagueIdService,
    getCountriesByContinentIdService,
};
