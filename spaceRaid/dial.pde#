#include "common.h"
#include "led.h"
#include "button.h"
#include "dial.h"

Led led = Led(3);
Led masterLed = Led(13);

Dial dial = Dial(2);
Button button = Button(12);

void change(){
  masterLed.switchState();
}

void setup(){
  Serial.begin(9600);
  attachInterrupt(0, change, RISING); 
}

void loop(){
  led.dimmTo(dial.readByte());
 
}
