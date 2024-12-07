const getAppProductsService = async () => {
    try {
        const query = `SELECT * FROM 'products'`;
    } catch (error) {
        throw error;
    }
};

module.exports = {
    getAppProductsService,
};
