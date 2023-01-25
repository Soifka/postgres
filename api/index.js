const axios = require('axios');

const http = axios.create({
    baseURL: 'https://randomuser.me/api/'
});

module.exports.loadUsers = async () => {
    const res = await http.get('?results=100')
};