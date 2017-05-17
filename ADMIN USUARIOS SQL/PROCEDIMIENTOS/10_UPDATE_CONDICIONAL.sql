delimiter $$

create procedure actualizarSupervisor()
begin

declare elCajero int(10);
declare elPiso int(10);
declare elSupervisor int(10);

declare fin boolean;


declare cur_actualizar cursor for
  select cajero, piso
    from venta, maquina_registradora
    where maquina_registradora.codigo = venta.maquina
    group by cajero;


declare continue handler for not found set fin = true;

set fin = false;

open cur_actualizar;/*Abrir cursor*/

l_c:loop /*Empieza el bucle*/

  fetch cur_actualizar into elCajero, elPiso;

  if fin=true then leave l_c; end if;

  IF elPiso = 1 OR elPiso = 2 THEN
    set elSupervisor = 1;
  END IF;

  IF elPiso = 3 OR elPiso = 4 THEN
    set elSupervisor = 2;
  END IF;

  IF elPiso = 5 THEN
    set elSupervisor = 3;
  END IF;

  UPDATE cajeros SET supervisor = elSupervisor WHERE codigo = elCajero;

end loop l_c;

/*cerrar cursor*/
close cur_actualizar;
end;
$$