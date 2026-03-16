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

#define GPIO_VAL_RD(pin) \
    (*(volatile u32 *)GPIO_R & (1 << pin) )

#define WAIT_KEY_RELEASE(pin) \
    while(GPIO_VAL_RD(pin) == 0);

typedef unsigned int u32;
typedef unsigned char u8;

void resetTIM(u32 val)
{
    *(u32 *)TIM_CTL = 0x4   ;
    *(u32 *)TIM_VAL = 0     ;
    *(u32 *)TIM_OVR = 0     ;
    *(u32 *)TIM_CNT = val   ;
    *(u32 *)TIM_CTL = 0x3   ;
}

int KeyIsDown(u32 pin)
{
    if(GPIO_VAL_RD(pin) == 0){
        for(u32 i = 0; i < 50000 ; i++);
        if(GPIO_VAL_RD(pin) == 0){
            return 1;
        }
    }
    return 0;
}

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

    // *(u32 *)TIM_CNT = 24000000 - 1  ;
    // *(u32 *)TIM_CNT = 270000 - 1  ;
    // *(u32 *)TIM_CTL = 0x3   ;
    resetTIM(27000000 - 1);

    volatile u32 cnt = 0, _cnt;
    u32 val = 1;
    u32 shifter_dir = 0;
    u32 uart_status;
    u32 uart_rx = 0;

    u32 gpio_mod = 0;
    u32 speed[3] = { 27000000, 2700000, 540000};
    while(1){
        // uart_status = *(volatile u32 *)UART_STATUS;
        // if((uart_status & 0x4) == 0){
        //     uart_rx = *(volatile u32 *)UART_DATA;
        // }
        // val = (cnt >> 8) | (uart_rx << 24);
        _cnt =  *(volatile u32 *)TIM_OVR  ;
        if(cnt != _cnt){
            cnt = _cnt  ;
            if(shifter_dir){
                val = val << 1;
                if(val == 0x40)
                    val = 1 ;
            }
            else{
                val = val >> 1;
                if(val == 0x0)
                    val = 0x20 ;
            }
        }
        *(u32 *)GPIO_W = ~val;

        if(KeyIsDown(15)){
            gpio_mod++;
            if(gpio_mod == 3) gpio_mod = 0;
            resetTIM(speed[gpio_mod] - 1);
            cnt = 0;
            WAIT_KEY_RELEASE(15);
        }

        if(KeyIsDown(16)){
            shifter_dir = !shifter_dir;
            WAIT_KEY_RELEASE(16);
        }
    }
}