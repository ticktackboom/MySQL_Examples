/* Muestra la lista de usuarios y contraseñas */
select * from mysql.user;

/* Muestra las tablas que existen en una base de datos */
show full tables from ciclismo;

/* Muestra las columnas de una tabla */
show columns from ciclismo.ciclista;

/* CREAR UN USUARIO EN MYSQL */
CREATE USER 'albertito' IDENTIFIED BY 'a';
/* Un usuario sin ningún privilegio no puede ver ni modificar la base de datos */


/* Crea el usuario con todos los privilegios posibles */
GRANT ALL PRIVILEGES
ON *.*
TO usuario1@localhost
IDENTIFIED BY 'contrasenya'
WITH GRANT OPTION;

/* Si el usuario ya existe, omitimos la contraseña */
GRANT ALL PRIVILEGES
ON *.*
TO usuario1@localhost
WITH GRANT OPTION;

GRANT SHOW DATABASES
ON *.* TO albertito;
/*

*.* = Todas las bases de datos con todas sus tablas.

 *  = Todas las tablas de la base de datos selecionada.

*/

