#include <Wire.h>
#include <Nunchuck.h>

class Manche {

public:
	void begin();
	
	void update();
	
	int getAcceleration();
	
	int getHorizontalMovement();
	
	int getVerticalMovement();
	
	boolean isFiring();
	
	boolean isNuking();
	
private:	
	Nunchuck nunchuck;
	
	int mapAngle(int angle);
};

void Manche::begin() {
	nunchuck.begin();
}

void Manche::update() {
	nunchuck.update();
}

int Manche::getAcceleration() {
        int angleY = nunchuck.readAngleY();
        if (angleY < 60) return -1;
        if (angleY > 120) return 1;
        return 0;
//        return mapAngle(angleY);
}

int Manche::mapAngle(int angle) {
        /*
        if (angleY < 60) return -1;
        if (angleY > 120) return 1;
        return 0;
        */
	return map(angle, 0, 180, -1, 1);
}

int Manche::getHorizontalMovement() {
        int joyX = nunchuck.readJoyX();
        return mapAngle(joyX);
}

int Manche::getVerticalMovement() {
        int joyY = nunchuck.readJoyY();
        return mapAngle(joyY);
}

boolean Manche::isFiring() {
	return nunchuck.readC();
}

boolean Manche::isNuking() {
	return nunchuck.readZ();
}
