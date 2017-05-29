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
    	/* El bucle va a ir leyendo el resultado de del cursor línea por línea (fila por fila).
	Cada vez que llamemos a FETCH, leerá la siguiente fila y volcará sus valores en las variables
	que hemos declarado. */
	FETCH mi_cursor INTO vprod, vtot;
	
	/*
		Si durante el FETCH ocurre que no quedan más filas por leer, se producirá un error.
		Al producirse un error, la variable "fin" se pondrá a TRUE porque estaba siendo manejada por el HANDLER.
		Ahora, si "fin" es TRUE, significa que el FETCH ha dado error, no ha devuelto una nueva fila, y por tanto,
		hay que cerrar el bucle.
	*/
	
        IF fin = TRUE THEN
		LEAVE miBucle;
	END IF;
	
	/*
		Si no he salido del bucle, inserto los datos que acabo de leer en la nueva tabla.
	*/
	
        INSERT INTO MAS_VENDIDOS_PROD values(vprod, vtot);
	
	END LOOP miBucle;
    
    /* Cerramos el cursor para liberar memoria */
    
    CLOSE mi_cursor;
        	
END$$

DELIMITER ;
