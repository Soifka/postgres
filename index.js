const { User, Phone, Order, client } = require('./model');
const { getUsers } = require('./api/fetch');
const { generatePhones } = require('./utils');


async function start() {
    await client.connect();

    // const userArray = await getUsers();
    // const res = await User.bulkCreate(userArray);

    const { rows: users } = await User.findAll();

    //const phones = generatePhones(100);
    const res = await Phone.bulkCreate(generatePhones(50));

    const orders = await Order.bulkCreate(users, phones);

    console.log(res);

    await client.end();
}

start();