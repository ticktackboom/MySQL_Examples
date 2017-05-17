/*
	Este procedimiento tiene como parámetro de entrada la edad, y como salida el total de la select.
*/

DELIMITER $$
CREATE PROCEDURE sp_name_edad (OUT TOTAL INT, IN V_EDAD INT)
BEGIN
	SELECT COUNT(*) INTO TOTAL FROM ciclista where edad > v_edad;
END
$$
call ciclismo.sp_name_edad(@a, 30);
$$
select @a;