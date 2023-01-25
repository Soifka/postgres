module.exports.getUsers = async () => {
    const res = await fetch('https://randomuser.me/api/?results=5');
    const data = await res.json();
    return data.results;
}