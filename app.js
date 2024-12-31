const express = require('express');
const bodyParser = require('body-parser');

const productRoutes = require('./routes/productRoutes');
const userRoutes = require('./routes/userRoutes');
const authRoutes = require('./routes/authRoutes');
const categoryRoutes = require('./routes/categoryRoutes');
const brandRoutes = require('./routes/brandRoutes');
const associationRoutes = require('./routes/associationRoutes');
const attributeRoutes = require('./routes/attributeRoutes');
const cartRoutes = require('./routes/cartRoutes');
const globalErrorHandler = require('./controllers/errorController');

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use('/api/products', productRoutes);
app.use('/api/users', userRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/categories', categoryRoutes);
app.use('/api/brands', brandRoutes);
app.use('/api/associations', associationRoutes);
app.use('/api/attributes', attributeRoutes);
app.use('/api/carts', cartRoutes);

app.all('*', (req, res, next) => {
    res.status(404).json({
        status: 'fail',
        message: `Can't find ${req.originalUrl} on this server!`,
    });
});

// handle error
app.use(globalErrorHandler);

module.exports = app;
