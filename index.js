const { Client } = require('pg');
const { password, database } = require('pg/lib/defaults');

const configs = {
    host: 'localhost',
    port: 5432,
    user: 'postgres',
    password: 'postgres',
    database: 'test'
}

const client = new Client(configs);

async function start() {
    await client.connect();

    const res = await client.query(`INSERT INTO users (first_name, last_name, email, is_subscribe) VALUES
    ('Tony', 'Stark', 'iron_man@gmail.com', true)`);

    console.log(res);

    await client.end();
}

start();