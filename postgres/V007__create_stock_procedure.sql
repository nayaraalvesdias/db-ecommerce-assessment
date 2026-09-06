create or replace function decrease_stock()
    returns trigger
as
$$
begin
    update products
    set stock = stock - new.quantity
    where id = new.product_id
      and stock >= new.quantity; -- decrease the stock if the stock is enough for the order

      -- check if the stock is enough for the order
      if stock < new.quantity then
        raise exception 'Not enough stock for product %', new.product_id;
      end if;

    return new;
end;
$$ language plpgsql;
