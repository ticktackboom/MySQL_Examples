/* Crear un procedimiento que busque los productos que comiencen por una letra */

DELIMITER $$

CREATE PROCEDURE datos_almacen.buscar_por_letra2(IN param1 VARCHAR(25))
	BEGIN
		SELECT count(*) from datos_almacen.productos WHERE nombre LIKE param1;
	END
$$



CALL datos_almacen.buscar_por_letra2('R%');