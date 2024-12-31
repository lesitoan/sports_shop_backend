const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');
const createSlug = require('../utils/createSlug');

const insertProductService = async (data, imageUrls) => {
    try {
        const connection = await pool.getConnection();
        const { name, price, quantity, categoryId, brandId, productAssociationId } = data;
        if (!name || !price || !quantity || !categoryId || imageUrls?.length === 0) {
            throw new AppError('Missing required fields', 400);
        }
        const slug = createSlug(name);

        await connection.beginTransaction(); // start transaction
        const query = `INSERT INTO products (name, slug, price, quantity, categoryId, brandId, productAssociationId) VALUES (?, ?, ?, ?, ?, ?, ?)`;
        const [productResult] = await connection.query(query, [
            name,
            slug,
            price,
            quantity,
            categoryId,
            brandId || null,
            productAssociationId || null,
        ]);

        const productId = productResult.insertId;
        const images = imageUrls.map((url) => [url, productId]);
        const queryImages = `INSERT INTO images (url, productId) VALUES ?`;
        await connection.query(queryImages, [images]);

        await connection.commit(); // commit transaction

        return productResult;
    } catch (error) {
        throw error;
    }
};

const getProductByIdService = async (productId) => {
    try {
        const query = `SELECT 
                            products.*, categories.name as category, brands.name as brand,
                            JSON_ARRAYAGG(images.url) as imageUrls,
                            JSON_ARRAYAGG( JSON_OBJECT(
                                'attrName', attributes.attrName,
                                'attrValue', attributes.attrValue,
                                'price', attributes.price
                            )) AS attributes
                        FROM products
                        LEFT JOIN images ON products.id = images.productId
                        LEFT JOIN productAttributes ON products.id = productAttributes.productId
                        LEFT JOIN attributes ON productAttributes.attributeId = attributes.id
                        LEFT JOIN categories ON products.categoryId = categories.id
                        LEFT JOIN brands ON products.brandId = brands.id
                        WHERE products.id = ?
                        GROUP BY products.id`;
        const [product] = await pool.query(query, [productId]);
        if (!product || !product[0]) {
            throw new AppError('Product not found', 404);
        }

        //modify data
        if (product[0].imageUrls[0] === null) {
            product[0].imageUrls = null;
        } else {
            product[0].imageUrls = [...new Set(product[0].imageUrls)];
        }
        if (product[0].attributes[0].price === null) {
            product[0].attributes = null;
        } else {
            product[0].attributes = Array.from(new Set(product[0].attributes.map((item) => JSON.stringify(item)))).map(
                (item) => JSON.parse(item),
            );
        }

        return product[0];
    } catch (error) {
        throw error;
    }
};

const getProductsService = async (filter) => {
    try {
        let { category, brand, league, continent, association, limit, page } = filter;
        limit = limit || 50;
        page = page || 1;
        const offset = (page - 1) * limit;
        let query = `SELECT 
                        products.*, categories.name as category, brands.name as brand,
                        JSON_ARRAYAGG(images.url) as imageUrls
                    FROM products
                    LEFT JOIN images ON products.id = images.productId
                    LEFT JOIN categories ON products.categoryId = categories.id
                    LEFT JOIN brands ON products.brandId = brands.id
                    LEFT JOIN productAssociations ON products.productAssociationId = productAssociations.id
                    WHERE 1 `;

        if (association) {
            query += ` AND productAssociations.slug = '${association}'`;
        } else if (league) {
            query += ` AND productAssociations.leagueId = (SELECT id FROM leagues WHERE slug = '${league}')`;
        } else if (continent) {
            query += ` AND productAssociations.continentId = (SELECT id FROM continents WHERE slug = '${continent}')`;
        }

        if (category) {
            query += ` AND categories.slug = '${category}'`;
        }
        if (brand) {
            query += ` AND brands.slug = '${brand}'`;
        }

        query += ` GROUP BY products.id LIMIT ${limit} OFFSET ${offset}`;

        const [products] = await pool.query(query);
        return products;
    } catch (error) {
        throw error;
    }
};

const addProductAttributesService = async (productId, attributes) => {};
const updateProductByIdService = async (productId, data) => {};

const deleteProductByIdService = async (productId) => {};

module.exports = {
    insertProductService,
    getProductByIdService,
    getProductsService,
};
