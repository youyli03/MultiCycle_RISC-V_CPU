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

#include "oled/OLED.h"
#include "oled/dino.h"

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
    // unsigned char buf[] = "Game";
    *(u32 *)GPIO_D = 0xff00 | 0x8 | 0x4 | 0x3 ;
    *(u32 *)GPIO_W = 0xa04;
    OLED_Init();
    OLED_DisplayStr(100,0,"Game",4);
    // resetTIM(1080000-1);//25hz
    // resetTIM(9000-1);//25hz
    // resetTIM(27000000-1);//25hz
    Dino_Start();

    // unsigned char buf[] = "hello world!";
    while(1){
        // OLED_DisplayStr(0,0,buf);
        // OLED_Fill(0xff);
        // OLED_Fill(0x00);
    }
}