#include "DelayIntervalReader.h"
#include <Arduino.h> 

void DelayIntervalReader::init(int _pin) {
	this->pin = _pin;
	pinMode(_pin, INPUT);
}

int DelayIntervalReader::read() {
	return analogRead(pin);
}

