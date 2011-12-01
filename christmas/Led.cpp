#include "Led.h"


void Led::init(int _pin){
    pin = _pin;
    pinModeOutput();
  }

  void Led::toggle() {
    if (state) off(); 
    else on();
  } 

  void Led::blink() {
    toggle(); 
    delay(100);
    toggle();
  } 

  void Led::on() {
    digitalWrite(pin, HIGH);
    state = true;
  }

  void Led::off() {
    digitalWrite(pin, LOW);
    state = false;
  }


  void Led::pinModeOutput(){
    pinMode(pin, OUTPUT);
  }


