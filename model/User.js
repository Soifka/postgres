const { mapUsers } = require('../utils');

class User {
    static _client;
    static _tableName;

    static async findAll() {
        return await this._client.query(`SELECT * FROM ${this._tableName}`);
    }

    static bulkCreate(usersArray) {
        return this._client.query(
            `INSERT INTO ${this._tableName} (first_name, last_name, email, is_subscribe, birthday, gender) VALUES
            ${mapUsers(usersArray)} RETURNING id`
        );
    }
}

module.exports = User;