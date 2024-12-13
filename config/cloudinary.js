const cloudinary = require('cloudinary').v2;

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_NAME,
    api_key: process.env.CLOUDINARY_KEY,
    api_secret: process.env.CLOUDINARY_SECRET,
});

const uploadCloudinary = (files) => {
    const resPromises = files.map(
        (file) =>
            new Promise((resolve, reject) => {
                cloudinary.uploader
                    .upload(file.path, {
                        folder: 'products/ao_bong_da_clb',
                    })
                    .then((result) => {
                        resolve(result);
                    })
                    .catch((error) => {
                        reject(error);
                    });
            }),
    );
    return Promise.all(resPromises);
};

module.exports = uploadCloudinary;
