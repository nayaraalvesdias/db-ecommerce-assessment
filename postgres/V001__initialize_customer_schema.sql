create table if not exists customers
(
    id         uuid primary key,
    first_name varchar(255) not null,
    last_name  varchar(255) not null,
    email      varchar(255) not null,
    phone      varchar(255) not null,
    is_active  boolean      not null,
    created_at timestamp    not null default now(),
    updated_at timestamp    not null default now(),
    constraint constraint_customer_email unique (email)
);

create table if not exists customer_addresses
(
    id          uuid primary key,
    customer_id uuid references customers (id) not null,
    street      varchar(255)                   not null,
    number      varchar(255)                   not null,
    complement  varchar(255),
    district    varchar(255)                   not null,
    city        varchar(255)                   not null,
    state       varchar(255)                   not null,
    zip_code    varchar(255)                   not null,
    created_at  timestamp                      not null default now(),
    updated_at  timestamp                      not null default now()
);

create index if not exists customer_id_customer_addresses_index on customer_addresses (customer_id);

create table if not exists customer_card
(
    id          uuid primary key,
    customer_id uuid references customers (id),
    type        varchar(255) not null,
    card_number varchar(255) not null,
    expiration  varchar(255) not null,
    cvv         varchar(255) not null,
    main        boolean               default false,
    created_at  timestamp    not null default now(),
    updated_at  timestamp    not null default now()
);

create index if not exists customer_id_customer_card_index on customer_card (customer_id);