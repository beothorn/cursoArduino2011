#include "common.h"
#include "led.h"
#include "button.h"
#include "dial.h"
#include <Servo.h>
#include <Wire.h>
#include <Nunchuck.h>
#include "lcd.h"
#include "base.h"


Nunchuck nunchuck;

Plane * plane;
Entity* entities[10]; 

int planeSpeed;

void setup(){
  Serial.begin(9600);
  GLCD.Init(NON_INVERTED);
  plane = new Plane();
  plane->center();
  entities[0] = new Rock();
  entities[1] = new Rock();
  entities[2] = new Rock();
  entities[3] = new Rock();
  entities[4] = new Rock();
  entities[5] = new Rock();
  entities[6] = new Rock();
  entities[7] = new Rock();
  entities[8] = new Fuel();
  entities[9] = new Fuel();
  planeSpeed = 25;
  
}



void loop(){
	
	if (plane->isDead()){
		return;
	}
	
	GLCD.ClearScreen();
	plane->tick();
	plane->draw();
	for(int i=0;i<10;++i) {
		entities[i]->draw();
		entities[i]->tick();
		if( i < 8 ) {
			plane->testRock(entities[i]);
		} else {
			plane->fuelIfNecessary(entities[i]);
		}
	}
	
	
	delay(planeSpeed);
	
}