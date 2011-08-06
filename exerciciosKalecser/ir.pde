#include "common.h"
#include "led.h"
#include "button.h"
#include "dial.h"
#include <ir.h>

IrReceiver receiver = IrReceiver(5);


void setup(){
  Serial.begin(9600);
}

void loop(){
  Serial.println(receiver.receive()); 
}
