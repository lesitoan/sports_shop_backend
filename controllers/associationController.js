const {
    getAllContinentsService,
    getAllLeaguesService,
    getClubsByLeagueIdService,
    getCountriesByContinentIdService,
    insertAssociationService,
} = require('../services/associationServices');
const AppError = require('../utils/AppError');

const insertAssociation = async (req, res, next) => {
    try {
        const result = await insertAssociationService(req.body);
        if (result.affectedRows === 0) {
            return next(new AppError('Insert club failed', 400));
        }
        return res.status(201).json({
            status: 'success',
            message: 'Insert club success',
            data: null,
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

const getAllLeagues = async (req, res, next) => {
    try {
        const leagues = await getAllLeaguesService();
        res.status(200).json({
            status: 'success',
            count: leagues.length,
            data: {
                leagues,
            },
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

const getAllContinents = async (req, res, next) => {
    try {
        const continents = await getAllContinentsService();
        res.status(200).json({
            status: 'success',
            count: continents.length,
            data: {
                continents,
            },
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

const getClubsByLeagueId = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const clubs = await getClubsByLeagueIdService(id);
        res.status(200).json({
            status: 'success',
            count: clubs.length,
            data: {
                clubs,
            },
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

const getCountriesByLeagueId = async (req, res, next) => {
    try {
        const { id } = req.params;
        if (!id) {
            return next(new AppError('ID is required', 400));
        }
        const countries = await getCountriesByContinentIdService(id);
        res.status(200).json({
            status: 'success',
            count: countries.length,
            data: {
                countries,
            },
        });
    } catch (error) {
        // lỗi  người dùng hoặc lỗi sql
        if (error.statusCode || error.code) {
            console.log(error.message);
            next(error);
        } else {
            // lỗi server
            console.log(error.message);
            next(new AppError('server error !!!!', 500));
        }
    }
};

// const deleteClubById = async (req, res, next) => {
//     try {
//         const { id } = req.params;
//         if (!id) {
//             return next(new AppError('ID is required', 400));
//         }
//         const result = await deleteClubByIdService(id);
//         if (result.affectedRows === 0) {
//             return next(new AppError('Delete club failed', 400));
//         }
//         return res.status(200).json({
//             status: 'success',
//             message: 'Delete club success',
//             data: null,
//         });
//     } catch (error) {
//         // lỗi  người dùng hoặc lỗi sql
//         if (error.statusCode || error.code) {
//             console.log(error.message);
//             next(error);
//         } else {
//             // lỗi server
//             console.log(error.message);
//             next(new AppError('server error !!!!', 500));
//         }
//     }
// };

module.exports = {
    insertAssociation,
    getAllLeagues,
    getAllContinents,
    getClubsByLeagueId,
    getCountriesByLeagueId,
};
