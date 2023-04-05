
                    /*--------------------------------------------------*\
                    |       File:           main.c                      |
                    |       Contains:       Zynq Application            |
                    |       System:         ZedBoard (Rev D.2)          |
                    |       FPGA:           XC7Z020-CLG484-1            |
                    |       CPU-Frequency:  100MHz                      |
                    |       IDE:            Xilinx Vitis 2022.2.0       |
                    |       Date:           2023.02.25.                 |
                    \*--------------------------------------------------*/

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpiops.h"
#include "xparameters.h"
#include "sleep.h"

// UART:        ps7_uart
// Baudrate:    115200
// Byte:        8
// Parity:      None
// Stopbit:     1


//==============================================//
//=============  Global variables  =============//
//==============================================//
XGpioPs GPIO;


//==============================================//
//===============  Enumerations  ===============//
//==============================================//
typedef enum test_algorithm_t
{
    MATSP    = 0x00, // MATS+ algorithm
    MATSPP   = 0x01, // MATS++ algorithm
}TEST_ALGORITHM;


//==============================================//
//===========  Function declaration  ===========//
//==============================================//
unsigned int read_databus(unsigned char address, unsigned char width);
void set_led(unsigned char status);
void set_bist_algorithm(TEST_ALGORITHM algorithm);
void set_bist_en(unsigned char status);
void set_bist_continue(unsigned char status);
unsigned char get_bist_running(void);
unsigned char get_bist_error(void);
unsigned char get_reset(void);
void reset_bist(void);



//==============================================//
//================  Definitions  ===============//
//==============================================//
#define GPIO_OFFSET 54
#define INPUT       0
#define OUTPUT      1
#define SEL_MPP_PIN GPIO_OFFSET+21
#define CONTIN_PIN  GPIO_OFFSET+20
#define RST_PIN     GPIO_OFFSET+19
#define LD0_PIN     GPIO_OFFSET+18
#define EN_PIN      GPIO_OFFSET+17
#define ERR_PIN     GPIO_OFFSET+16
#define RUN_PIN     GPIO_OFFSET+15
#define ADDR_PIN    GPIO_OFFSET



int main()
{
    init_platform();
    unsigned char done_flag = 0;
    unsigned long int error_flag = 0;

    XGpioPs_Config *config_GPIO;

    config_GPIO = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    XGpioPs_CfgInitialize(&GPIO, config_GPIO, config_GPIO->BaseAddr);
    XGpioPs_SetDirectionPin(&GPIO, LD0_PIN, OUTPUT);    // LD0 as output
    XGpioPs_SetDirectionPin(&GPIO, RST_PIN, INPUT);     // Reset as input
    XGpioPs_SetDirectionPin(&GPIO, RST_PIN, OUTPUT);    // Reset as input

    XGpioPs_SetDirectionPin(&GPIO, ADDR_PIN, INPUT);    // Address as input
    XGpioPs_SetDirectionPin(&GPIO, RUN_PIN, INPUT);     // Run as input
    XGpioPs_SetDirectionPin(&GPIO, ERR_PIN, INPUT);     // Error as input

    XGpioPs_SetDirectionPin(&GPIO, EN_PIN, OUTPUT);     // Enable as output
    XGpioPs_SetDirectionPin(&GPIO, CONTIN_PIN, OUTPUT); // Continue as output
    XGpioPs_SetDirectionPin(&GPIO, SEL_MPP_PIN, OUTPUT);// MATS++ algorithm selection as output

    reset_bist();

    while(1)
    {
        if(get_reset())
        {
            xil_printf("  >> Reset button pressed!\n");
            done_flag = 0;
            error_flag=0;
            set_led(0);
            sleep(1);
        }
        else
        {
            if(done_flag == 0)
            {
                set_led(0);
                xil_printf("################ Start BIST #################\n\n");
                set_bist_algorithm(MATSP);
                set_bist_en(1);

                while(get_bist_running())
                {
                    if(get_bist_error())
                    {
                        xil_printf("  >> Error on Address: 0x%04X\n", read_databus(ADDR_PIN, 15));
                        error_flag++;
                        set_bist_continue(1);
                    }
                    set_bist_continue(0);
                }

                if(error_flag)
                {
                    xil_printf("\n########## BIST found %lu memory errors ##########\n", error_flag);
                }
                else
                {
                    xil_printf("\n##########  BIST successfully finished  ##########\n");
                }

                set_bist_en(0);
                set_led(1);
                done_flag = 1;
            }
            else
            {
                set_led(1);
            }
        }
    }

    cleanup_platform();
    return 0;
}


unsigned int read_databus(unsigned char address, unsigned char width)
{
    unsigned char i = 0;
    unsigned int retval = 0;


    for(i=0; i<width; i++)
    {
        retval |= XGpioPs_ReadPin(&GPIO, address+i) << i;
    }

    return retval;
}


void set_led(unsigned char status)
{
    if(status)
    {
        XGpioPs_WritePin(&GPIO, LD0_PIN, 1);
    }
    else
    {
        XGpioPs_WritePin(&GPIO, LD0_PIN, 0);
    }
}


void set_bist_algorithm(TEST_ALGORITHM algorithm)
{
    if(algorithm == MATSPP)
    {
        XGpioPs_WritePin(&GPIO, SEL_MPP_PIN, 1);
    }
    else
    {
        XGpioPs_WritePin(&GPIO, SEL_MPP_PIN, 0);
    }
}


void set_bist_en(unsigned char status)
{
    if(status)
    {
        XGpioPs_WritePin(&GPIO, EN_PIN, 1);
    }
    else
    {
        XGpioPs_WritePin(&GPIO, EN_PIN, 0);
    }
}


void set_bist_continue(unsigned char status)
{
    if(status)
    {
        XGpioPs_WritePin(&GPIO, CONTIN_PIN, 1);
    }
    else
    {
        XGpioPs_WritePin(&GPIO, CONTIN_PIN, 0);
    }
}


unsigned char get_bist_running(void)
{
    if(XGpioPs_ReadPin(&GPIO, RUN_PIN))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}


unsigned char get_bist_error(void)
{
    if(XGpioPs_ReadPin(&GPIO, ERR_PIN))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}


unsigned char get_reset(void)
{
    if(XGpioPs_ReadPin(&GPIO, RST_PIN))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}


void reset_bist(void)
{
    XGpioPs_WritePin(&GPIO, RST_PIN, 1);
    usleep(1000);
    XGpioPs_WritePin(&GPIO, RST_PIN, 0);
}
