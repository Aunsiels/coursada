with Ada.Real_Time; use Ada.Real_Time;

package body Cours4 is

--Definition d'une task avec une priority de 20
  task Blink1 is
    pragma Priority (20);
  end Blink1;

--Corps de la tache

  task body Blink1 is
  begin
--faire clignoter une led
   Setup_Out_Pin(Pin1);
    loop
      Set_Pin(Pin1,True);
      delay until Clock + To_Time_Span (0.5);
      Set_Pin(Pin1,False);
      delay until Clock + To_Time_Span (0.5);
    end loop;
  end Blink1;

--Idem pour une autre led

  task Blink4 is
    pragma Priority (20);
  end Blink4;

  task body Blink4 is
  begin
   Setup_Out_Pin(Pin4);
    loop
      Set_Pin(Pin4,True);
      delay until Clock + To_Time_Span (1.0);
      Set_Pin(Pin4,False);
      delay until Clock + To_Time_Span (1.0);
    end loop;
  end Blink4;

--une boucle de faisant rien d'autre qu'attendre
  procedure rien is
  begin
    loop
     delay until Clock + To_Time_Span (1.0);
    end loop;
  end rien;

end Cours4;
