/* Crear un procedimiento que inserte en la tabla morosos
los clientes que han hecho pedidos y no han hecho ningún pago

debes insertar el código de cliente y la suma total de los pedidos
que no han pagado */

DELIMITER $$

CREATE PROCEDURE actualizar_morosos()
BEGIN
	declare ccliente int(10);
    declare deuda decimal(15,2);
    
    DECLARE fin boolean;

	declare miCursor cursor for
	  select distinct CodigoCliente
      from pedidos
      where CodigoCliente not in (select CodigoCliente from pagos);
    
    declare continue handler for not found set fin = true;
    /* Nota: Entre todos los declares, el handler va el último */

	CREATE TABLE IF NOT EXISTS jardineria.morosos(CodigoCliente int(10) primary key, deuda decimal(15,2), foreign key (CodigoCliente) references clientes (CodigoCliente));
	TRUNCATE TABLE jardineria.morosos;
    
    set fin = false;
    
    open miCursor;
    
    miBucle: loop

		fetch miCursor into ccliente;
        
        if fin = true then leave miBucle; end if;
        
        select sum(cantidad * precioUnidad) into deuda
        from pedidos, detallepedidos
        where CodigoCliente = ccliente
        and pedidos.CodigoPedido = detallepedidos.CodigoPedido
        group by pedidos.CodigoPedido;
        
        insert into morosos values(ccliente, deuda);
        
        
    end loop miBucle;
    
    
END
$$

DELIMITER ;

