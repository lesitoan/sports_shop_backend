const validateEmail = (email) => {
    const re =
        /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
};

const validatePassword = (password) => {
    const re = /^[^\s]{8,}$/;
    return re.test(password);
};

const validateUserName = (userName) => {
    const re = /^[a-zA-Z0-9]{5,}$/;
    return re.test(userName);
};

module.exports = {
    validateEmail,
    validatePassword,
    validateUserName,
};
