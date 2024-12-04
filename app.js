const express = require('express');
const productRoutes = require('./routes/productRoutes');
const userRoutes = require('./routes/userRoutes');
const globalErrorHandler = require('./controllers/errorController');

const app = express();
app.use('/api/products', productRoutes);
app.use('/api/users', userRoutes);

app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'fail',
        message: `Can't find ${req.originalUrl} on this server!`,
    });
});

// handle error
app.use(globalErrorHandler);

module.exports = app;
