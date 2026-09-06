CREATE TABLE IF NOT EXISTS customers
(
    id         uuid PRIMARY KEY,
    first_name varchar(255) not null,
    last_name  varchar(255) not null,
    email      varchar(255) not null,
    phone      varchar(255) not null,
    is_active  boolean      not null,
    created_at timestamp    not null default now(),
    updated_at timestamp    not null default now(),
    CONSTRAINT constraint_name UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS customer_addresses
(
    id          uuid PRIMARY KEY,
    customer_id uuid REFERENCES customers (id),
    street      varchar(255) not null,
    number      varchar(255) not null,
    complement  varchar(255),
    district    varchar(255) not null,
    city        varchar(255) not null,
    state       varchar(255) not null,
    zip_code    varchar(255) not null,
    created_at  timestamp    not null default now(),
    updated_at  timestamp    not null default now()
);

CREATE INDEX IF NOT EXISTS customer_id_customer_addresses_index ON customer_addresses (customer_id);

CREATE TABLE IF NOT EXISTS customer_card
(
    id          uuid PRIMARY KEY,
    customer_id uuid REFERENCES customers (id),
    type        varchar(255) not null,
    card_number varchar(255) not null,
    expiration  varchar(255) not null,
    cvv         varchar(255) not null,
    main        boolean,
    created_at  timestamp    not null default now(),
    updated_at  timestamp    not null default now()
);

CREATE INDEX IF NOT EXISTS customer_id_customer_card_index ON customer_card (customer_id);