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
	
  pinMode(12, OUTPUT);     
  pinMode(13, OUTPUT);     
	
}

void loop() {
	manche.update();

	int acceleration = manche.getAcceleration();
	boolean morefuel = manche.isFiring() || manche.isNuking();
	int horizontal = manche.getHorizontalMovement();
	int vertical = manche.getVerticalMovement();
	
	applyAcceleration(acceleration);
	applyFuel(morefuel);
	applyHorizontal(horizontal);	
	applyVertical(vertical);	
	
    delay(10);
}


void applyAcceleration(int acceleration) {       
	speed += acceleration;
	if (speed > MAX_SPEED) {
		speed = MAX_SPEED;
	}
	if (speed < 0) {
		speed = 0;
	}
		
	dash.setSpeed(speed);
}

void applyFuel(boolean morefuel) {
	if (morefuel) {
		resupplyFuel();
	} else {
		spendFuel();
	}
	
	
	dash.setFuel(fuel);

}

void resupplyFuel() {
		fuel += FUEL_RESUPPLY;
		if (fuel > MAX_FUEL) {
			fuel = MAX_FUEL;
		}
}

void spendFuel() {
		fuel--;
		if (fuel < 0) {
			fuel = 0;
		}
}

void applyHorizontal(int increment) {
	showMovementOnLed(increment, 13);
}

void applyVertical(int increment) {
	showMovementOnLed(increment, 12);
}

void showMovementOnLed(int movement, int led) {
	if (movement == 0) {
		digitalWrite(led, LOW);   
	} else {
		digitalWrite(led, HIGH);
	}
};
