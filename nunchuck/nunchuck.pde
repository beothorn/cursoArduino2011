#include <Nunchuck.h>
#include <Servo.h>

Nunchuck nunchuck;
Servo lowerMotor;
Servo upperMotor;

void setup()
{
	Serial.begin(9600);
	nunchuck.begin();
	lowerMotor.attach(9);
	upperMotor.attach(10);
}
int angle = 0;
int dir=1;
boolean pressed = false;
boolean pressed2 = false;
void loop()
{
	nunchuck.update();
	int s = nunchuck.readAngleX();
	Serial.println(s, DEC);
//	lowerMotor.write(s);
	if (nunchuck.zPressed()) {
		if(pressed)
			upperMotor.write(0);
		else
			upperMotor.write(180);
		pressed = !pressed;	
	}
	if (nunchuck.cPressed()) {
		if(pressed2)
			lowerMotor.write(0);
		else
			lowerMotor.write(180);
		pressed2 = !pressed2;	
	}

	/*
	lowerMotor.write(angle);
	angle+=dir*10;
	if (angle == 0 || angle == 180){
		dir=dir*-1;
	}
	*/
	delay(20);

//	lowerMotor.write(nunchuck.readAngleX());
//	motor2.write(nunchuck.readAngleY());

#if 0
	char msg[40];
	sprintf(msg, "Accel: %d %d %d", nunchuck.readAccelX(), nunchuck.readAccelY(), nunchuck.readAccelZ());
	Serial.println(msg);

	sprintf(msg, "Angles: %d %d %d", nunchuck.readAngleX(), nunchuck.readAngleY(), nunchuck.readAngleZ());
	Serial.println(msg);

	sprintf(msg, "Button -Z %d", nunchuck.zPressed());
	Serial.println(msg);

	sprintf(msg, "Button -C %d", nunchuck.cPressed());
	Serial.println(msg);

	delay(100);
#endif
}
