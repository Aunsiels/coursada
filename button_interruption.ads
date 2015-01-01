with Stm32.NVIC; use Stm32.NVIC;
pragma Elaborate_All (Stm32.NVIC);

package Button_Interruption is

    protected type Button_Interface is
        procedure EXTI0_Interrupt_Handler;
        pragma Attach_Handler(EXTI0_Interrupt_Handler, EXTI0_IRQn);
    end Button_Interface;

    Btn : aliased Button_Interface;

end Button_Interruption;
