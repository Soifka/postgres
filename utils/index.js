/*
module.exports.mapUsers = (userArray) => {
    return userArray.map((user) => `('${user.firstName}', '${user.lastName}', '${user.email}', ${user.isSubscribe})`)
    .join(',');
};
*/

/*
'${user.firstName}', '${user.lastName}', '${user.email}', ${user.isSubscribe})`
*/


const _ = require('lodash');

module.exports.mapUsers = (userArray) => {
    return userArray
    .map(
        ({
            name: { first, last },
            gender,
            email,
            dob: { date }
        }) => `('${first}', '${last}', '${email}', ${Boolean(Math.random() > 0.5)}, '${date}', '${gender}')`)
    .join(',');
};


const PHONES_BRANDS = [
    'Samsung',
    'Huawei',
    'iPhone',
    'Nokia',
    'Sony',
    'Motorola',
    'Xiaomi',
    'Realme'
];


const generateOnePhone = (key) => ({
    brand: PHONES_BRANDS[_.random(0, PHONES_BRANDS.length - 1, false)],
    model: `model ${key}`,
    quantity: _.random(10, 1500, false),
    price: _.random(1500, 8000, false),
    category: 'phones'
});

/*
module.exports.generatePhones = length => {
    const phonesArray = [];
    for(let i = 0; i < length; i++) {
        phohesArray.push(generateOnePhone(i))
    }
    return phonesArray;
}
*/

module.exports.generatePhones = (length) => 
    new Array(length).fill(null).map((elem, i) => generateOnePhone(i));
