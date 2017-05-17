/*
EJERCICIO 8
Crear un procedimiento que utiliza un cursor para insertar en la tabla MAS_VENDIDOS los 2 productos más vendidos
*/

DELIMITER $$
/* 0º Le damos nombre al procedimiento */
CREATE PROCEDURE p_mas_vendidos()
BEGIN
	/* 1º: Declaro las variables que voy a usar para lo que extraiga del cursor en el FETCH */
    DECLARE vtot int(10);
    DECLARE vprod int(11);
    DECLARE fin BOOLEAN; /* Para el bucle */
    
    /* Declaro el cursor
    y la select que extraerá la información */
	DECLARE mi_cursor CURSOR FOR 
		SELECT count(*), producto
        FROM datos_almacen.venta
        GROUP BY producto
        ORDER BY count(*) desc
        LIMIT 2;
	
    /* Creo un manejador que capturará el error 2000,
    que significa que no quedan más filas */
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET fin = TRUE;
    /* En vez de SQLSTATE '02000' podemos gastar 'NOT FOUND'
    sin comillas */
    
    /* Ya hemos declarado todo, ahora toca hacer el programa,
    ahora asignamos valores a las variables */
    
    SET fin = FALSE;
    SET vtot = 0;
    SET vprod = 0;
    
    /* Ahora ABRIMOS el cursor */
    
    OPEN mi_cursor;
    
    miBucle:LOOP
		FETCH mi_cursor INTO vprod, vtot;
        IF fin = TRUE THEN
				LEAVE miBucle;
		END IF;
        INSERT INTO MAS_VENDIDOS_PROD values(vprod, vtot);
	END LOOP miBucle;
    
    /* Cerramos el cursor para liberar memoria */
    
    CLOSE mi_cursor;
        	
END$$

DELIMITER ;