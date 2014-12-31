with Ada.Real_Time; use Ada.Real_Time;
with Stm32.GPIO; use Stm32.GPIO;
with Stm32.RCC; use Stm32.RCC;
pragma Elaborate_All (Stm32.GPIO);

procedure Cours1 is
--Definir la Pin
  Pin : constant Pin_Type := (GPIOD, 12);
begin
--Configurer la pin comme une pin de sortie
   Setup_Out_Pin(Pin);
  loop
--Allumer la pin, attendre un peu, eteindre la pin, attendre un peu
    Set_Pin(Pin,True);
    delay until Clock + To_Time_Span (1.0);
    Set_Pin(Pin,False);
    delay until Clock + To_Time_Span (1.0);
  end loop;
end Cours1;
