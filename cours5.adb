with Stm32.Timer; use Stm32.Timer;
with Stm32.GPIO; use Stm32.GPIO;
with Stm32.RCC; use Stm32.RCC;
pragma Elaborate_All (Stm32.GPIO);
with Interfaces; use Interfaces;

procedure Cours5 is
--Configurer les parametres du timer
  Params : constant Timer_Params :=
    (Prescaler =>40000,
     Counter_Mode => Up,
     Period => 500,
     Clock_Division => Div_1,
     Repetition_Counter => 0);
--Declarer une pin et une variable de type Unsigned_32 qui contiendra la valeur du compteur
     Pin : constant Pin_Type := (GPIOD, 12);
     Val : Unsigned_32 := 0;
begin
--Configurer Pin et le timer
  Setup_Out_Pin(Pin);
  Init_Timer (1, Params, Disable, 0);
  loop
--Recuperer la valeur du compteur et si egal a 250, Toggle_Pin(Pin)
    Val := Get_Counter(1);
    if (Val = 250) then
      Toggle_Pin(Pin);
    end if;
  end loop;
end Cours5;
