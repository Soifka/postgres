const { Client } = require('pg');
const User = require('./User');
const Phone = require('./Phone');
const Order = require('./Order');
const { configs } = require('../configs');

const client = new Client(configs);

User._client = client;
User._tableName = 'users';

Phone._client = client;
Phone._tableName = 'products';

Order._client = client;

module.exports = {
    client,
    User,
    Phone,
    Order
}