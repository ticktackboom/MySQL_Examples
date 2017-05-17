/*
	Crear un TRIGGER que controle el stock de un producto al realizar
    una venta.
    
    Si el sstock es menor que las unidades que se venden, se cancela la operación.
    
    Si el stock es suficiente, se actualiza el stock del producto.
*/

DELIMITER $$

create trigger datos_almacen.T1
before insert on venta
for each row
begin

	declare vstock int(3);
    
    select stock into vstock from productos where codigo = new.producto;
    
    if vstock < 1 then
		signal sqlstate '45000' set message_text = 'Error', mysql_errno = 1.001;
        
	else
		update productos set stock = stock - 1 where codigo = new.producto;
    end if;

end
$$

DELIMITER ;
/*
	Ahora, cada vez que se introduzca una nueva venta en la tabla "ventas",
    la tabla productos se actualizará restando 1 unidad de stock en el producto vendido.
*/

insert into venta values(1, 11, 100, '2017/05/10');
select * from productos;