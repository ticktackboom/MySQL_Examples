CREATE TABLE IF NOT EXISTS datos_almacen.supervisores(CodS INT primary key, nombre varchar(25), salario int, plus varchar(22));


/*
	Cambiamos el delimitador a $$.
    Por defecto, es ;, pero los procedimientos van a contener puntos y comas y se puede rallar, por tanto lo cambiamos para evitar conflictos.
    Es obligatorio cambiarlo.
*/

DELIMITER $$

CREATE PROCEDURE datos_almacen.insert_supervisores(IN cod INT, IN nombre varchar(25), IN salario INT(10))
	BEGIN
		INSERT INTO datos_almacen.supervisores (CodS, nombre, salario) VALUES(cod, nombre, salario);
	END;
$$

DELIMITER ;

CALL insert_supervisores(1, 'Pepito1', 1400);
CALL insert_supervisores(2, 'Pepito2', 1500);
CALL insert_supervisores(3, 'Pepito3', 1600);

select * from datos_almacen.supervisores;