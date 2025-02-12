module.exports = {
    apps: [
        {
            name: 'app1',
            script: './server.js',
            env: {
                PORT: 3000,
                DB_HOST: '',
                DB_user: '',
                DB_PASSWORD: '',
                DB_NAME: '',
                JWT_SECRET: '',
                ACCESS_TOKEN_EXPIRES_IN: '',
                REFRESH_TOKEN_EXPIRES_IN: '',

                MAILTRAP_USERNAME: '',
                MAILTRAP_PW: '',
                MAILTRAP_HOST: '',
                MAILTRAP_PORT: '',

                CLOUDINARY_NAME: '',
                CLOUDINARY_KEY: '',
                CLOUDINARY_SECRET: '',
            },
        },
    ],
};
