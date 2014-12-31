with Ada.Real_Time; use Ada.Real_Time;

package body Cours4 is

--Corps de la tache

  task body Blink is
  begin
--faire clignoter une led
   Setup_Out_Pin(Pin.all);
    loop
      Set_Pin(Pin.all,True);
      delay until Clock + To_Time_Span (0.5);
      Set_Pin(Pin.all,False);
      delay until Clock + To_Time_Span (0.5);
    end loop;
  end Blink;

--une boucle de faisant rien d'autre qu'attendre
  procedure rien is
  begin
    loop
     delay until Clock + To_Time_Span (1.0);
    end loop;
  end rien;

end Cours4;
