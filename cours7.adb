with Stm32.Timer; use Stm32.Timer;
with Ada.Real_Time; use Ada.Real_Time;
with Stm32.GPIO; use Stm32.GPIO;
with Stm32.RCC; use Stm32.RCC;
pragma Elaborate_All (Stm32.GPIO);
with Interfaces; use Interfaces;

procedure Example is
--Declaration des parametres du timer
  Params_Timer : constant Timer_Params :=
    (Prescaler =>0,
     Counter_Mode => Up,
     Period => 8399,
     Clock_Division => Div_1,
     Repetition_Counter => 0);
--Declaration des pwm et des pins associees
  Params_PWM1 : constant Output_Channel_Params :=
    (Mode => PWM2,
     Output_State => Enable,
     Output_N_State => Disable,
     Polarity => Low,
     Pulse => 2099,
     N_Polarity => High,
     Idle_State => Reset,
     N_Idle_State => Reset);
  Pin1 : constant Pin_Type := (GPIOD,12);
  Params_PWM2 : constant Output_Channel_Params :=
    (Mode => PWM2,
     Output_State => Enable,
     Output_N_State => Disable,
     Polarity => Low,
     Pulse => 4199,
     N_Polarity => High,
     Idle_State => Reset,
     N_Idle_State => Reset);
  Pin2 : constant Pin_Type := (GPIOD,13);
  Params_PWM3 : constant Output_Channel_Params :=
    (Mode => PWM2,
     Output_State => Enable,
     Output_N_State => Disable,
     Polarity => Low,
     Pulse => 6299,
     N_Polarity => High,
     Idle_State => Reset,
     N_Idle_State => Reset);
  Pin3 : constant Pin_Type := (GPIOD,14);
  Params_PWM4 : constant Output_Channel_Params :=
    (Mode => PWM2,
     Output_State => Enable,
     Output_N_State => Disable,
     Polarity => Low,
     Pulse => 8399,
     N_Polarity => High,
     Idle_State => Reset,
     N_Idle_State => Reset);
  Pin4 : constant Pin_Type := (GPIOD,15);
  I : Unsigned_32 := 0;
begin
--Initialisation du Timer
  Init_Timer(4,Params_Timer,Disable,0);
--Configuration du channel de sortie
  Setup_Output_Channel(4,1,Params_PWM1);
--Configuration de la pin de sortie
  Configure_Output_Pin(4,Pin1);
  Setup_Output_Channel(4,2,Params_PWM2);
  Configure_Output_Pin(4,Pin2);
  Setup_Output_Channel(4,3,Params_PWM3);
  Configure_Output_Pin(4,Pin3);
  Setup_Output_Channel(4,4,Params_PWM4);
  Configure_Output_Pin(4,Pin4);
  loop
    Set_Compare(4,1,I);
    I := (I +1) mod 8400;
    delay until Clock + To_Time_Span (0.001);
  end loop;
end Example;
