with Stm32.RCC; use Stm32.RCC;
with Stm32.GPIO; use Stm32.GPIO;
pragma Elaborate_All (Stm32.GPIO);

package Cours4 is

--Definition d'une task avec une priority de 20
  task type Blink (Pin : access Pin_Type) is
    pragma Priority (20);
  end Blink;

--Declarer procedure et pins
  procedure rien;
  Pin0 : aliased Pin_Type := (GPIOD, 12);
  Pin1 : aliased Pin_Type := (GPIOD, 13);

  Blk1 : Blink(Pin1'Access);
  Blk0 : Blink(Pin0'Access);
end Cours4;
