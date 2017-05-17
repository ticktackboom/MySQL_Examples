/* Crear un usuario usu1 con password usu1, que tenga privilegios para seleccionar sobre
la tabla ciclista y que pueda otorgar estos privilegios sobre otros usuario. */

GRANT select
ON ciclista
TO usu1
IDENTIFIED BY 'usu1'
WITH GRANT OPTION;

/* Crear un usuario usu11 con password usu11, y desde el usuario usu1 asígnale permisos
de selección sobre la tabla ciclista. */


/* Desde esta cuenta haríamos: */
CREATE USER 'usu11' IDENTIFIED BY 'usu11';

/* */
GRANT select ON ciclista TO 'usu11';

/* 3. Asígnale al usuario usu1 permisos de selección y modificación sobre la tabla equipo. */

GRANT select, update ON equipo TO 'usu1';

/* 4. Crear un usuario usu2 con password usu2 que tenga privilegios de borrar, insertar filas,
seleccionar, modificar sobre las tablas ciclista, etapa y llevar. */

create user 'usu2' identified by 'usu2';

GRANT delete, insert, select, update ON ciclista TO usu2;
GRANT delete, insert, select, update ON etapa TO usu2;
GRANT delete, insert, select, update ON llevar TO usu2;

/* 5. Crea un usuario usu3 con password usu3 que tenga permiso de seleccionar datos
sobre todas las tablas de la base de datos grandes_almacenes y que pueda dar
permisos a otros usuarios */

GRANT select ON datos_almacen.cajeros TO usu3 IDENTIFIED BY 'usu3' WITH GRANT OPTION;
GRANT select ON datos_almacen.cajeros TO usu3 WITH GRANT OPTION;

/* 6. Haz que el usuario usu3 de permisos a usu31 para seleccionar en la tabla ventas de
grandes almacenes */

GRANT select ON datos_almacen.* TO usu31 IDENTIFIED BY 'usu31';

/* 7. Quítale al usuario usu3 permiso de seleccionar la tabla cajeros */

REVOKE select ON datos_almacen.cajeros FROM usu3;

select * from mysql.tables_priv;


flush tables;

set autocommit = 0;
start transaction;
select * from ciclista;
update ciclista set edad = edad-500;
select * from ciclista;
rollback;
select * from ciclista;
commit;

show variables;
