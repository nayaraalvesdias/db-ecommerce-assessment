create trigger trigger_name
    after update
    on order_items
    for each row
execute function decrease_stock();