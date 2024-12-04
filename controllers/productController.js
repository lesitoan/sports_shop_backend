const pool = require('../config/connectDB');

const getAllProducts = async (req, res) => {
    try {
        const [results, fields] = await pool.query('SELECT * FROM `products`');

        console.log(results);
        console.log(fields);
        res.send('Get all products !');
    } catch (err) {
        console.log(err);
    }
};

module.exports = {
    getAllProducts,
};
