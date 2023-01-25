const _ = require('lodash');

class Order {
    static _client;

    static async bulkCreate(users, products) {
        const ordersValueString = users.map(
            user => 
            new Array(_.random(1, 3, false))
            .fill(null)
            .map((user) => `(${user.id})`)
            .join(',')
        ).join(',');

    const { rows: orders } = await this._client.query(
        `INSERT INTO orders (customer_id) VALUES ${ordersValueString} RETURNING id;`
    );

    const phonesToOrdersValueString = orders.map(
        order => {
            {
                const arr = new Array(_.random(1, 4, false))
                .fill(null)
                .map(() => phones[_.random(1, phones.length - 1)]);

                return [...new Set(arr)]
                        .map(phone => `(${order.id}, ${phone.id}, ${_.random(1, 3, false)})`)
                        .join(',')
            }
        }
    ).join(',')

    const res2 = await this._client.query(
        `INSERT INTO orders_to_products (order_id, product_id, quantity) VALUES
        ${phonesToOrdersValueString} RETURNING id`
    )
    }
}

module.exports = Order;