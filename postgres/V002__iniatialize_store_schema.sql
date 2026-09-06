create table if not exists stores
(
    id         uuid primary key,
    name       varchar(255) not null,
    is_active  boolean      not null,
    created_at timestamp    not null default now(),
    updated_at timestamp    not null default now(),
    constraint constraint_store_name unique (name)
);

create table if not exists products
(
    id          uuid primary key,
    store_id    uuid references stores (id) not null,
    is_active   boolean                     not null,
    name        varchar(255)                not null,
    price       decimal(10, 2)              not null,
    quantity    integer                     not null,
    category    varchar(255)                not null,
    brand       varchar(255)                not null,
    description varchar(255)                not null,
    rating      decimal(10, 2),
    created_at  timestamp                   not null default now(),
    updated_at  timestamp                   not null default now()
);

create index if not exists store_id_products_index on products (store_id);