/* BD JARDINERÍA */

/* Crear un usuario con nombre "empleado" y contraseña "e1"
que tenga permiso para consultar y actualizar la tabla "perdidos"
y "detallepedidos" */

GRANT select, update
ON pedidos
TO 'empleado'
IDENTIFIED BY 'emp';

GRANT select, update
ON detallepedidos
TO empleado;

/* Otorga permiso a empleado para que pueda consultar las columnas
NombreCliente, Telefono, direccion de la tabla clientes */

GRANT select (NombreCliente, Telefono, LineaDireccion1)
ON clientes
TO empleado;

/* Crea un usuario de nombre administración y contraseña adm que tenga
permiso para consultar, actualizar y borrar los registros de la tabla oficinas,
empleados y clientes, y pueda otorgar este permiso a otros usuarios */
CREATE USER 'administracion' IDENTIFIED BY 'adm';

GRANT select, update, delete ON oficinas TO 'administracion' WITH GRANT OPTION;
GRANT select, update, delete ON empleados TO 'administracion' WITH GRANT OPTION;
GRANT select, update, delete ON clientes TO 'administracion' WITH GRANT OPTION;

/* Registrarte como usuario 'administracion' y que de permiso al usuario 'emp'
para que pueda consultar la tabla 'empleados' */

