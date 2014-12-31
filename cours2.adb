with Stm32.GPIO; use Stm32.GPIO;
with Stm32.RCC; use Stm32.RCC;
pragma Elaborate_All (Stm32.GPIO);

procedure Cours2 is
--Definir 2 pins : une pour l'emission et l autre pour la reception
  Pin1 : constant Pin_Type := (GPIOD, 12);
  Pin2 : constant Pin_Type := (GPIOA, 0);
  Params : constant GPIO_Params := (Pins => (Mask => (0 => True, others => False)),
    Mode        => Mode_In,
    Speed       => Speed_100MHz,
    Output_Type => PP,
    PuPd        => Pull_Down);
begin
--Configurer la pin d'entree et de sortie
  Setup_Out_Pin(Pin1);
  Config_GPIO(GPIOA, Params);
  loop
    Set_Pin(Pin1,Read_Pin(Pin2));
  end loop;
end Cours2;
