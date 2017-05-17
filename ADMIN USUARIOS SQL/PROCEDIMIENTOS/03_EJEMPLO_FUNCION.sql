/*
	Así se define una FUNCION.
*/

DELIMITER $$
CREATE FUNCTION sf_edad (V_EDAD INT)
RETURNS INTEGER
BEGIN
	DECLARE TOTAL INTEGER;
	SELECT COUNT(*) INTO TOTAL FROM ciclista where edad > v_edad;
    RETURN TOTAL;
END
$$
/* Se ejecuta con SELECT */
select ciclismo.sf_edad(30);
