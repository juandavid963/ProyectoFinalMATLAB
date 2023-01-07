#include <16F877a.h>
#fuses XT,NOWDT,NOPROTECT
#use delay(clock=4000000)
#use rs232 (BAUD=9600 , XMIT=PIN_C6 , RCV=PIN_C7 , BITS=8)
#include <lcd.c>
double dato1=0,temp=0;
int enviar1=0,tipo=0,band=0,band1=0;


void main() 
{ lcd_init();
  DELAY_MS(10);
  SETUP_ADC(ADC_CLOCK_INTERNAL);     
  SETUP_ADC_PORTS(ALL_ANALOG);          
  SET_ADC_CHANNEL(0); 
  DELAY_MS(10);
     
  while(true)
   { dato1=READ_ADC(); 
     DELAY_MS(20);
     temp=dato1/255*100;       
     if(band1!=dato1)
      { printf(lcd_putc , "\f Temp: %1.1f°C\n Juan Cerquera." ,temp);}
     band1=dato1;


     band = kbhit();
     if(band==1)
      { tipo=getc();
      }

     if(tipo==1)
     { enviar1=dato1;
       putc(enviar1);
     }     
   }
}


