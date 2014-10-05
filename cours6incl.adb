with Stm32.Timer; use Stm32.Timer;
with Stm32.GPIO; use Stm32.GPIO;
with Stm32.RCC; use Stm32.RCC;
pragma Elaborate_All (Stm32.GPIO);
with Ada.Real_Time; use Ada.Real_Time;

package body Cours6incl is
--Parametres du timer
  Params : constant Timer_Params :=
    (Prescaler =>40000,
     Counter_Mode => Up,
     Period => 40000,
     Clock_Division => Div_1,
     Repetition_Counter => 0);
--Declaration Pin
     Pin : constant Pin_Type := (GPIOE, 4);

--Creation du protected pour y mettre le handler

  protected Brightness is
--Déclaration du Handler et d'une procedure d'initialisation
    procedure main;
    procedure Timer_Handler;
--Lier le Handler avec l'interruption du timer
    pragma Attach_Handler (Timer_Handler, IRQ_Timer(2));
  end Brightness;

--Corps dyu protected

  protected body Brightness is
--Definition du handler
    procedure Timer_Handler is
    begin
--Toogle Pin et clear interruption
      Toggle_Pin(Pin);
      Clear_Interrupt(1, Update);
    end Timer_Handler;

    procedure main is
    begin
--Configurer Pin, reset timer, nettoyer interruption et initialiser timer
      Setup_Out_Pin(Pin);
      Reset_Timer(2);
      Clear_Interrupt(2,Update);
      Init_Timer (2, Params, Update, 0);
    end main;
  end Brightness;

--Procedure pricipale

  procedure run is
  begin
--Appel de l'initialisation
   Brightness.main;
   loop
--Attendre
     delay until Clock + To_Time_Span (1.0);
   end loop;
  end run;
end Cours6incl;
