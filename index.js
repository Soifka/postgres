const { Client } = require('pg');
const { password, database } = require('pg/lib/defaults');
const { mapUsers } = require('./utils');


const configs = {
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'postgres',
    database: 'test'
}

const client = new Client(configs);

const userArray = [{
    firstName: 'Vik',
    lastName: 'Doe',
    email: 'v.doe@gmail.com',
    isSubscribe: true
},
{
    firstName: 'Jack',
    lastName: 'Doe',
    email: 'jack.doe@gmail.com',
    isSubscribe: true
},
{
    firstName: 'Jane',
    lastName: 'Doe',
    email: 'jane.doe@gmail.com',
    isSubscribe: false
}]

async function start() {
    await client.connect();

    const res = await client.query(`INSERT INTO users (first_name, last_name, email, is_subscribe) VALUES
    ${mapUsers(userArray)}
    `);

    console.log(res);

    await client.end();
}

start();