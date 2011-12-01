#include "common.h"
#include "led.h"
#include "button.h"
#include "dial.h"
#include <Servo.h>
#include <Wire.h>
#include <Nunchuck.h>
#include "lcd.h"
#include "base.h"

#define ENTTITY_COUNT 10

Nunchuck nunchuck;

Plane * plane;
Entity* entities[ENTTITY_COUNT]; 

int planeSpeed;

void setup(){
  Serial.begin(9600);
  GLCD.Init(NON_INVERTED);
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

  plane = new Plane();
  plane->center();
  
}



void loop(){
	
	if (plane->isDead()){
		return;
	}
	
	GLCD.ClearScreen();
	plane->tick();
	plane->draw();
	for(int i=0;i<ENTTITY_COUNT; ++i) {
		entities[i]->draw();
		entities[i]->tick();
		if( i < 8 ) {
			plane->testRock(entities[i]);
		} else {
			plane->fuelIfNecessary(entities[i]);
		}
		plane->destroyIfHit(entities[i]);
	}
	
	
	delay(planeSpeed);
	
}
