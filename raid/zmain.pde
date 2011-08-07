//#include <Servo.h>
//#include <Wire.h>
//#include <Nunchuck.h>

//Nunchuck nunchuck;
Dashboard dash;
Manche manche;

const int MAX_SPEED = 180;
const int MAX_FUEL = 180;
const int FUEL_RESUPPLY = 5;

int speed = 0;

int fuel = 0;

void setup() {
	dash.attach(2, 3);
	manche.begin();
}

void loop() {
	manche.update();

	int acceleration = manche.getAcceleration();
	boolean morefuel = manche.isFiring();
	
	speed += acceleration;
	if (speed > MAX_SPEED) {
		speed = MAX_SPEED;
	}
	if (speed < 0) {
		speed = 0;
	}
		
	if (morefuel) {
		fuel += FUEL_RESUPPLY;
		if (fuel > MAX_FUEL) {
			fuel = MAX_FUEL;
		}
	} else {
		fuel--;
		if (fuel < 0) {
			fuel = 0;
		}
	}
	
	dash.setSpeed(speed);
	
	dash.setFuel(fuel);

	/*
    if (nunchuck.readZ()) {
        servo1.write(nunchuck.readAngleX());
        servo2.write(nunchuck.readAngleY());
    }

//    if (nunchuck.readC()) {
        servo1.write(map(nunchuck.readJoyX(), 5, 250, 0, 180));
        servo2.write(map(nunchuck.readJoyY(), 5, 250, 0, 180));
//    }

*/
    
    delay(10);
}
