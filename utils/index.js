module.exports.mapUsers = (userArray) => {
    return userArray.map((user) => `('${user.firstName}', '${user.lastName}', '${user.email}', ${user.isSubscribe})`)
    .join(',');
};

/*
'${user.firstName}', '${user.lastName}', '${user.email}', ${user.isSubscribe})`
*/