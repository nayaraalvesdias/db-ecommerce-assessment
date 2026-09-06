CREATE TABLE IF NOT EXISTS orders
(
    id          uuid PRIMARY KEY,
    customer_id uuid references customers (id),
    status      varchar(255),
    total       numeric(10, 2),
    created_at  timestamp not null default now(),
    updated_at  timestamp not null default now()
);

CREATE INDEX IF NOT EXISTS orders_customer_id_idx ON orders (customer_id);

CREATE TABLE IF NOT EXISTS order_items
(
    id         uuid primary key,
    order_id   uuid references orders (id),
    product_id uuid references products (id),
    quantity   integer,
    created_at timestamp not null default now(),
    updated_at timestamp not null default now()
);

CREATE TABLE IF NOT EXISTS order_transactions
(
    id               uuid PRIMARY KEY,
    order_id         uuid references orders (id),
    customer_card_id uuid references customer_card (id),
    status           varchar(255),
    amount           numeric(10, 2),
    created_at       timestamp not null default now(),
    updated_at       timestamp not null default now()
);