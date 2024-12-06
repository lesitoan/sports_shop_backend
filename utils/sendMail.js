const nodemailer = require('nodemailer');

// Create a transporter object
const transporter = nodemailer.createTransport({
    host: process.env.MAILTRAP_HOST,
    port: process.env.MAILTRAP_PORT,
    secure: false, // use SSL
    auth: {
        user: process.env.MAILTRAP_USERNAME,
        pass: process.env.MAILTRAP_PW,
    },
});

// Configure the mailoptions object
const sendMail = async (email, subject, message) => {
    return new Promise((resolve, reject) => {
        if (!email || !subject || !message) {
            resolve(false);
        }
        const mailOptions = {
            from: 'sportsshop@gmail.com',
            to: email,
            subject: subject,
            text: message,
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.log('Error sending email: ', error);
                resolve(false);
            } else {
                console.log('Email sent: ' + info.response);
                resolve(true);
            }
        });
    });
};

module.exports = sendMail;
