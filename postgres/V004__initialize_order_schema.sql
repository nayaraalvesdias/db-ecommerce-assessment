create table if not exists orders
(
    id          uuid primary key,
    customer_id uuid references customers (id) not null,
    status      varchar(50)                   not null,
    total       numeric(10, 2)                 not null,
    created_at  timestamp                      not null default now(),
    updated_at  timestamp                      not null default now()
);

create index if not exists orders_customer_id_idx on orders (customer_id);

create table if not exists order_items
(
    id         uuid primary key,
    order_id   uuid references orders (id)   not null,
    product_id uuid references products (id) not null,
    quantity   integer                       not null,
    created_at timestamp                     not null default now(),
    updated_at timestamp                     not null default now()
);

create table if not exists order_transactions
(
    id               uuid primary key,
    order_id         uuid references orders (id)        not null,
    customer_card_id uuid references customer_card (id) not null,
    status           varchar(50)                       not null,
    amount           numeric(10, 2)                     not null,
    created_at       timestamp                          not null default now(),
    updated_at       timestamp                          not null default now()
);