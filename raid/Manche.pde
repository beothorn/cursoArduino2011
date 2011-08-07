#include <Wire.h>
#include <Nunchuck.h>

class Manche {

public:
	void begin();
	
	void update();
	
	int getAcceleration();
	
	boolean isFiring();
	
private:	
	Nunchuck nunchuck;
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
}

boolean Manche::isFiring() {
	return nunchuck.readC();
}