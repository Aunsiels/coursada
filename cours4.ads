with Stm32.RCC; use Stm32.RCC;
with Stm32.GPIO; use Stm32.GPIO;
pragma Elaborate_All (Stm32.GPIO);


package Cours4 is
--Declarer procedure et pins
  procedure rien;
  Pin4 : constant Pin_Type := (GPIOE, 4);
  Pin1 : constant Pin_Type := (GPIOE, 1);
end Cours4;
