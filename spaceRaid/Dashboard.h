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

void Dashboard::setSpeed(int value) {
	this->speed.write(180 - value);
}
	
	
void Dashboard::setFuel(int value) {
	this->fuel.write(180 - value);
}

