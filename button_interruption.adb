with Stm32.Led; use Stm32.Led;
with Stm32.GPIO; use Stm32.GPIO;
with Stm32.RCC; use Stm32.RCC;
pragma Elaborate_All (Stm32.GPIO);
with Stm32.EXTI; use Stm32.EXTI;
pragma Elaborate_All (Stm32.EXTI);
with Stm32.SYSCFG; use Stm32.SYSCFG;
pragma Elaborate_All (Stm32.SYSCFG);
with Stm32.Defines; use Stm32.Defines;

package body Button_Interruption is

--The onboard user button
    User_Button : constant EXTI_Source := (SYSCFG_GPIOA, PinSource0);

--GPIOA parameters
    Params : constant GPIO_Params := (Pins => (Mask => (0 => True, others => False)),
        Mode        => Mode_In,
        Speed       => Speed_100MHz,
        Output_Type => PP,
        PuPd        => Pull_Down); --For the user button.

--External interrupt parameters.
    Params_EXTI : constant EXTI_Params :=
        (EXTI => (Mask => (0 => True, others => False)), --The first line...
        Mode => Mode_Interrupt, -- Generates interrupts
        Trigger => Rising, -- Triggers on rising edge.
        LineCmd => Enable); -- Enable the interrupts.

    protected body Button_Interface is
--The interrupt handler.
        procedure EXTI0_Interrupt_Handler is
        begin
--Check if it is the right interrupt.
            if EXTI_GetITStatus (EXTI_Line0) then
--Toggle the Led3.
                Led_Toggle(Led3);
--Clear the interrupt.
                EXTI_ClearITPendingBit(EXTI_Line0);
            end if;
        end EXTI0_Interrupt_Handler;
    end Button_Interface;

begin

--Configure the button.
    Config_GPIO (GPIOA, Params);
--Configure the EXTI line.
    Config_EXTILine (User_Button);
--Configure the EXTI.
    Config_EXTI(Params_EXTI);
--Activate the EXTI0 interrupt.
    NVIC_Init (EXTI0_IRQn, 1);

end Button_Interruption;
