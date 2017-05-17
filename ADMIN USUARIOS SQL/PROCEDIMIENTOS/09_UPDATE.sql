/*
EJERCICIO 9
 Actualizar el campo total de la tabla PRODUCTOS con el total de unidades que se han vendido
*/

DELIMITER $$
/* 0º Le damos nombre al procedimiento */
CREATE PROCEDURE actualizar_total_vendidos()
BEGIN
	/* 1º: Declaro las variables que voy a usar para lo que extraiga del cursor en el FETCH */
    DECLARE id_producto int(10);
    DECLARE total_vendidos int(11);
    DECLARE fin BOOLEAN; /* Para el bucle */
    
    /* Declaro el cursor
    y la select que extraerá la información */
	DECLARE mi_cursor CURSOR FOR 
		select producto, count(*) from venta group by producto;
	
    /* Creo un manejador que capturará el error 2000,
    que significa que no quedan más filas */
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET fin = TRUE;
    /* En vez de SQLSTATE '02000' podemos gastar 'NOT FOUND'
    sin comillas */
    
    /* Ya hemos declarado todo, ahora toca hacer el programa,
    ahora asignamos valores a las variables */
    
    SET fin = FALSE;
    
    /* Ahora ABRIMOS el cursor */
    
    	UPDATE productos set total = 0;

    OPEN mi_cursor;
    
    miBucle:LOOP
		FETCH mi_cursor INTO id_producto, total_vendidos;
        
        IF fin = TRUE THEN
				LEAVE miBucle;
		END IF;
        
        UPDATE productos SET total = total_vendidos WHERE codigo = id_producto;

	END LOOP miBucle;
    
    /* Cerramos el cursor para liberar memoria */
    
    CLOSE mi_cursor;
        	
END$$

DELIMITER ;