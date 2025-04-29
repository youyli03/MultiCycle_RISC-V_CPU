#define GPIO_R 0Xf0000000
#define GPIO_D 0Xf0000004
#define GPIO_W 0Xf0000008

#define UART_STATUS 0Xf0001000
#define UART_DATA   0Xf0001004
#define UART_BAUD   0Xf0001008

#define TIM_CTL 0Xf0002000
#define TIM_CNT 0Xf0002004
#define TIM_VAL 0Xf0002008
#define TIM_OVR 0Xf000200c

typedef unsigned int u32;
typedef unsigned char u8;

int main()
{
    *(u32 *)GPIO_W = 0x114514;
    // *(u32 *)UART_BAUD = 443;
    *(u32 *)UART_BAUD = 149;

    *(u32 *)UART_DATA = 0x11;
    *(u32 *)UART_DATA = 0x45;
    *(u32 *)UART_DATA = 0x14;
    *(u32 *)UART_DATA = 0x19;
    *(u32 *)UART_DATA = 0x19;
    *(u32 *)UART_DATA = 0x87;
    *(u32 *)UART_DATA = 0x00;

    *(u32 *)TIM_CNT = 0x9   ;
    *(u32 *)TIM_CTL = 0x3   ;

    volatile u32 cnt;
    u32 val;
    u32 uart_status;
    u32 uart_rx = 0;
    while(1){
        uart_status = *(volatile u32 *)UART_STATUS;
        if((uart_status & 0x4) == 0){
            uart_rx = *(volatile u32 *)UART_DATA;
        }
        cnt =  *(volatile u32 *)TIM_OVR  ;
        val = (cnt >> 8) | (uart_rx << 24);
        *(u32 *)GPIO_W = val;
    }
}