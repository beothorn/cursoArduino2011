//#include "Dashboard.h"
#include <Servo.h> 


class Dashboard {
public:
	void attach(int speedPin, int fuelPin);
	
	void setSpeed(int value);
		
	void setFuel(int value);
private:
	Servo speed;
	
	Servo fuel;
	
};


void Dashboard::attach(int speedPin, int fuelPin) {
	this->speed.attach(speedPin);
	this->fuel.attach(fuelPin);
}

/*
void Dashboard::reset() {
	this->speed.write(0);
	this->fuel.write(0);
	wait(15);
}
*/

void Dashboard::setSpeed(int value) {
	this->speed.write(180 - value);
	//wait(15);
}
	
	
void Dashboard::setFuel(int value) {
	this->fuel.write(value);
	//wait(15);
}
