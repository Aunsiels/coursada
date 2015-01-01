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

    User_Button : constant EXTI_Source := (SYSCFG_GPIOA, PinSource0);

    Params : constant GPIO_Params := (Pins => (Mask => (0 => True, others => False)),
        Mode        => Mode_In,
        Speed       => Speed_100MHz,
        Output_Type => PP,
        PuPd        => Pull_Down);

    Params_EXTI : constant EXTI_Params :=
        (EXTI => (Mask => (0 => True, others => False)),
        Mode => Mode_Interrupt,
        Trigger => Rising,
        LineCmd => Enable);

    protected body Button_Interface is
        procedure EXTI0_Interrupt_Handler is
        begin
            if EXTI_GetITStatus (EXTI_Line0) then
                Led_Toggle(Led3);
                EXTI_ClearITPendingBit(EXTI_Line0);
            end if;
        end EXTI0_Interrupt_Handler;
    end Button_Interface;

begin

    Config_GPIO (GPIOA, Params);
    Config_EXTILine (User_Button);
    Config_EXTI(Params_EXTI);
    NVIC_Init (EXTI0_IRQn, 1);
    Led_On(Led3);

end Button_Interruption;
