-- Functional Queries: Provide queries that demonstrate CRUD operations, data retrieval, and aggregation.

-- enable cascade delete for customer_addresses table
ALTER TABLE customer_addresses
    DROP CONSTRAINT customer_addresses_customer_id_fkey;

ALTER TABLE customer_addresses
    ADD CONSTRAINT customer_addresses_customer_id_fkey
        FOREIGN KEY (customer_id)
            REFERENCES customers (id)
            ON DELETE CASCADE;

-- adding new customer
insert into customers(id,
                      first_name,
                      last_name,
                      email,
                      phone,
                      is_active,
                      created_at,
                      updated_at)
VALUES ('3bfe3ded-eaa8-4689-9edc-cbbc6c0d22a3',
        'Nayara',
        'Dias',
        'random_email@email.com.br',
        '+553199999999',
        true,
        now(),
        now());

-- adding new customer address
insert into customer_addresses(id,
                               customer_id,
                               street,
                               number,
                               complement,
                               district,
                               city,
                               state,
                               zip_code,
                               created_at,
                               updated_at)
VALUES ('82333161-1ce7-45a5-8ec1-78cc20714312',
        '3bfe3ded-eaa8-4689-9edc-cbbc6c0d22a3',
        'street',
        '60',
        null,
        'distric',
        'Belo Horizonte',
        'Minas Gerais',
        '00000000',
        now(),
        now());

-- select new customer added

select *
from customers
         left join customer_addresses on customers.id = customer_addresses.customer_id
where customers.id = '3bfe3ded-eaa8-4689-9edc-cbbc6c0d22a3';

-- update customer 
update customers
set email      = 'new_email@email.com',
    updated_at = now()
where id = '3bfe3ded-eaa8-4689-9edc-cbbc6c0d22a3';
 
select * from customers where id = '3bfe3ded-eaa8-4689-9edc-cbbc6c0d22a3';

-- update customer address     

update customer_addresses
set number     = '70',
    updated_at = now()
where id = '82333161-1ce7-45a5-8ec1-78cc20714312';

select * from customer_addresses where id = '82333161-1ce7-45a5-8ec1-78cc20714312';

-- delete customer and customera address with cascade delete
delete
from customers
where id = '3bfe3ded-eaa8-4689-9edc-cbbc6c0d22a3';
