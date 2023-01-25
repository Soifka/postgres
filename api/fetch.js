module.exports.getUsers = async () => {
    const res = await fetch('https://randomuser.me/api/?results=500&seed=onl');
    const data = await res.json();
    return data.results;
}