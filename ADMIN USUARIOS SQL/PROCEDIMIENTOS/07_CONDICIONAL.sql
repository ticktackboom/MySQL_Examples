DELIMITER $$
CREATE PROCEDURE insertar_producto(IN v_codigo INT(11), IN v_nombre VARCHAR(100), IN v_precio INT (11), IN v_total INT(11), IN v_stock INT, IN v_tipo VARCHAR(22))
	BEGIN
		IF v_tipo = 'consumible' THEN
			insert into CONSUMIBLES values (v_codigo, v_nombre, v_precio, v_total, v_stock, v_tipo);
		ELSEIF v_tipo = 'equipamiento' THEN
			insert into PRODUCTOS values (v_codigo, v_nombre, v_precio, v_total, v_stock, v_tipo);
        END IF;
	END;
DELIMITER ;

CALL insertar_producto(1, 'cartucho color hp', 30, 5, 6, 'consumible');
CALL insertar_producto(2, 'cartucho color hp', 30, 5, 6, 'equipamiento');
CALL insertar_producto(3, 'cartucho color hp', 30, 5, 6, 'aaaaaa');
/* El tercero no hará nada */
