/* Crear un procedimiento que busque los productos que comiencen por una letra */

DROP procedure IF EXISTS datos_almacen.buscar_por_letra;

DELIMITER $$
CREATE PROCEDURE datos_almacen.buscar_por_letra(IN param1 VARCHAR(25), OUT TOTAL INT)
	BEGIN
		SELECT count(*) into TOTAL from datos_almacen.productos WHERE nombre LIKE param1;
	END
$$

DELIMITER ;

CALL datos_almacen.buscar_por_letra('R%', @TOTAL);

SELECT @TOTAL;

