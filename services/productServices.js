const pool = require('../config/connectDB');
const AppError = require('../utils/AppError');
const createSlug = require('../utils/createSlug');

const insertProductService = async (data, imageUrls) => {
    try {
        const { name, price, quantity, categoryId, brandId, productAssociationId, attributes } = data;
        if (!name || !price || !quantity || !categoryId || imageUrls?.length === 0) {
            throw new AppError('Missing required fields', 400);
        }
        const slug = createSlug(name);

        const connection = await pool.getConnection();
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

        // if(attributes) {
        //     const attributesData = JSON.parse(attributes);
        //     if(attributesData.length > 0) {
        //         const attributes = attributesData.map((item) => [productId, item.attribute, item.price]);
        //         const queryAttributes = `INSERT INTO attributes (productId, attribute, price) VALUES ?`;
        //         await connection.query(queryAttributes, [attributes]);
        //     }
        // }

        await connection.commit(); // commit transaction

        return productResult;
    } catch (error) {
        throw error;
    }
};

const getProductBySlugService = async (productSlug) => {
    try {
        const query = `SELECT 
                            products.*, categories.name as category, brands.name as brand,
                            JSON_ARRAYAGG(images.url) as imageUrls,
                            JSON_ARRAYAGG( JSON_OBJECT(
                                'attrName', attributes.attrName,
                                'attrValue', attributes.attrValue,
                                'addPrice', productattributes.addPrice,
                                'productAttributeId', productattributes.id
                            )) AS attributes
                        FROM products
                        LEFT JOIN images ON products.id = images.productId
                        LEFT JOIN productattributes ON products.id = productattributes.productId
                        LEFT JOIN attributes ON productattributes.attributeId = attributes.id
                        LEFT JOIN categories ON products.categoryId = categories.id
                        LEFT JOIN brands ON products.brandId = brands.id
                        WHERE products.slug = ?
                        GROUP BY products.id`;
        const [product] = await pool.query(query, [productSlug]);
        if (!product || !product[0]) {
            throw new AppError('Product not found', 404);
        }

        //modify data
        if (product[0].imageUrls[0] === null) {
            product[0].imageUrls = null;
        } else {
            product[0].imageUrls = [...new Set(product[0].imageUrls)];
        }
        if (product[0].attributes[0].addPrice === null) {
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
        let { category, brand, league, continent, association, limit, page, q, sort } = filter;
        page = page || 1;
        let query = `
            SELECT 
                products.*,
                categories.name AS categoryName,
                categories.slug AS categorySlug,
                brands.name AS brand,
                JSON_ARRAYAGG(images.url) AS imageUrls,
                COUNT(*) OVER() AS count
            FROM products
            LEFT JOIN images ON products.id = images.productId
            LEFT JOIN categories ON products.categoryId = categories.id
            LEFT JOIN brands ON products.brandId = brands.id
            LEFT JOIN productassociations ON products.productAssociationId = productassociations.id
            WHERE 1 `;

        if (association) {
            query += ` AND productassociations.slug = '${association}'`;
        } else if (league) {
            query += ` AND productassociations.leagueId = (SELECT id FROM leagues WHERE slug = '${league}')`;
        } else if (continent) {
            query += ` AND productassociations.continentId = (SELECT id FROM continents WHERE slug = '${continent}')`;
        }

        if (category) {
            query += ` AND categories.slug = '${category}'`;
        }
        if (brand) {
            query += ` AND brands.slug = '${brand}'`;
        }
        if (q) {
            query += ` AND products.slug LIKE '%${q}%'`;
        }
        query += ` GROUP BY products.id`;

        if (sort) {
            if (sort === 'price') {
                query += ` ORDER BY price ASC`;
            } else if (sort === 'price_desc') {
                query += ` ORDER BY price DESC`;
            } else if (sort === 'name') {
                query += ` ORDER BY name ASC`;
            } else if (sort === 'name_desc') {
                query += ` ORDER BY name DESC`;
            } else if (sort === 'newest') {
                query += ` ORDER BY createAt DESC`;
            } else if (sort === 'oldest') {
                query += ` ORDER BY createAt ASC`;
            }
        }
        if (limit) {
            const offset = (page - 1) * limit;
            query += ` LIMIT ${limit} OFFSET ${offset}`;
        }

        const [products] = await pool.query(query);
        let count = 0;
        if (products?.length > 0) {
            count = products[0].count;
            products.map((item) => delete item.count);
        }
        return { count, products };
    } catch (error) {
        throw error;
    }
};

const addproductattributesService = async (productId, attributes) => {};
const updateProductByIdService = async (productId, data) => {};

const deleteProductByIdService = async (productId) => {};

module.exports = {
    insertProductService,
    getProductBySlugService,
    getProductsService,
};
