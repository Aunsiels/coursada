with Stm32.RCC; use Stm32.RCC;
with Stm32.GPIO; use Stm32.GPIO;
pragma Elaborate_All (Stm32.GPIO);
with Stm32.UART; use Stm32.UART;
pragma Elaborate_All (Stm32.UART);
with Interfaces; use Interfaces;
with Stm32.NVIC; use Stm32.NVIC;
with Stm32.Defines; use Stm32.Defines;
with Ada.Real_Time; use Ada.Real_Time;

package body Cours3 is

  UART : constant UART_Number := 3;
  protected type UART_Interface is
    procedure UART_Interrupt_Handler;
    procedure Initialize (Tx_Pin : Pin_Type; Rx_Pin : Pin_Type; Speed : Integer);
  private
    Rx : Boolean := Get_Interrupt_Flag_Status(UART, RXNE);
    C : Unsigned_16;
    pragma Attach_Handler(UART_Interrupt_Handler,
                           Stm32.UART.IRQ (UART));
  end UART_Interface;

  Pin : constant Pin_Type := (GPIOE, 4);
  UART_N : aliased UART_Interface;
  protected body UART_Interface is
    procedure UART_Interrupt_Handler is
      Ma_Chaine : String(1..1);
    begin
        -- Is there something to read ?
        Rx := Get_Interrupt_Flag_Status(UART, RXNE);
        if Rx then
          C := Stm32.UART.Receive_Data (UART);
          Ma_Chaine(1) := Character'Val(C);
          if (Ma_Chaine(1) ='c') then
            Set_Pin(Pin,False);
          end if;
        end if;
    end UART_Interrupt_Handler;

    procedure Initialize (Tx_Pin : Pin_Type; Rx_Pin : Pin_Type; Speed : Integer) is
      Params : constant UART_Params := (
        Baud_Rate    => Unsigned_32 (Speed),
        Word_Length  => Length_8,
        Stop_Bit     => Stop_1,
        Parity       => No_Parity,
        Mode         => Mode_Both,
        Flow_Control => None);
    begin
      Configure_Pins (UART, Tx_Pin, Rx_Pin);
      UART_Init (UART, Params);
      Configure_Interrupt (UART, RXNE, Enable);
      NVIC_Init (Stm32.UART.IRQ (UART), 1);
    end Initialize;
  end UART_Interface;

  procedure Main is
  begin
    Setup_Out_Pin(Pin);
    Set_Pin(Pin,True);
    UART_N.Initialize((GPIOD,8),(GPIOD,9),115200);
    loop
      delay until Clock + To_Time_Span (10.0);
    end loop;
  end Main;

begin
   Cours3.Main;
end Cours3;
