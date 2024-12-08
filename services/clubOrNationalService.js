const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');

const insertClubOrNationalService = async (payload) => {
    // continent is one in ['Asia', 'Africa', 'Europe', 'NorthAmerica', 'SouthAmerica']
    try {
        const { club, nation, league, continent } = payload;
        if (!nation || !league || !continent) {
            throw new AppError('Enter all required data', 400);
        }
        // if (club) {
        //     const clubData = await pool.query(`SELECT * FROM clubOrNationals WHERE club = '${club}'`);
        //     if (clubData[0].length > 0) {
        //         throw new AppError('Club already exists', 409);
        //     }
        // }
        const query = `INSERT INTO clubOrNationals (club, nation, league, continent) VALUES
                        ('${club || ''}', '${nation || ''}', '${league}', '${continent}')`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const getAllClubsService = async (payload) => {
    try {
        const { type } = payload;
        let query = `SELECT * FROM clubOrNationals`;
        if (type === 'nation') {
            query += ` WHERE club = ''`;
        }
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

const deleteClubByIdService = async (id) => {
    try {
        const query = `DELETE FROM clubOrNationals WHERE id = ${id}`;
        const response = await pool.query(query);
        return response[0];
    } catch (error) {
        throw error;
    }
};

module.exports = {
    insertClubOrNationalService,
    getAllClubsService,
    deleteClubByIdService,
};
