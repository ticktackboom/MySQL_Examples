/*
	Realizar un procedimiento que obtenga los productos de los que tenemos una rotura de stock.
    
    Para ello debes filtrar los pedidos pendientes, de estos pedidos,
    calcular las unidades producto que se han pedido,
    y comparar con el stock que hay de ese producto Insertar en la tabla rotura
    el producto y la cantidad que falta.
*/

DELIMITER $$

create procedure p_rotura_stock()
begin
	declare vcodproducto varchar(15);
    declare vtot int(5);
    declare vstock int(5);
    declare vrotura int(5);
    declare fin boolean;

/*
	Vamos a sacar de los pedidos pendientes cuánto stock tenemos de cada uno de los productos pedidos
*/
    
    declare cursor_rotura cursor for
		select CodigoProducto, sum(Cantidad)
		from pedidos,detallepedidos
		where Estado = 'pendiente'
		and Pedidos.CodigoPedido = detallepedidos.CodigoPedido
		group by CodigoProducto;
    
    declare continue handler for not found set fin = 1;
    
    set fin = 0;
    
    open cursor_rotura;
    
    bucle:loop
		
        fetch cursor_rotura into vcodproducto, vtot;
        
        if fin = 1 then leave bucle; end if;
        
        select CantidadEnStock
			into vstock
			from productos
			where CodigoProducto = vcodproducto;
        
        if vstock < vtot then
			set vrotura = vtot - vstock;
			
            insert into rotura (CodigoProducto, rotura)
            values (vcodproducto, vrotura);
            
		end if;
        
        
        
	end loop bucle;
    
    close cursor_rotura;
    
END$$