/*

  Christmas tree.

*/

#include "Led.h"
#include "Button.h"
#include "SequenceCollection.h"
#include "LightCollection.h"


const int buttonPin = 2;
const int speedAnalogInput = A0;
const int LED_DISPLAY_STARTING_PORT = 4;
const int NUMBER_OF_LEDS = 5; // 10;


class BlinkLightStrategy : public LightStrategy {
public:
	void light(Led * led) {
		led->blink();
	}
};

class ToggleLightStrategy : public LightStrategy {
public:
	void light(Led * led) {
		led->toggle();
	}
};


class ForwardSequenceStrategy : public SequenceStrategy {
public:
	void iterate(
		Led leds[], int numberOfLeds, 
		LightStrategy * light, DelayIntervalReader * interval) {
		for (int i = 0; i < numberOfLeds; i++) 
		{
			Led * led = &leds[i];
			light->light(led);
			delay(interval->read());
		}
	}
};

class BackwardSequenceStrategy : public SequenceStrategy{
public:
	void iterate(
		Led leds[], int numberOfLeds, 
		LightStrategy * light, DelayIntervalReader * interval) {
		for (int i = numberOfLeds - 1; i >= 0; i--) 
		{
			Led * led = &leds[i];
			light->light(led);
			delay(interval->read());
		}
	}
};



Led leds[NUMBER_OF_LEDS];
Button buttonLight;
Button buttonSequence;
DelayIntervalReader interval;

ForwardSequenceStrategy forward;
BackwardSequenceStrategy backward;
ToggleLightStrategy toggle;
BlinkLightStrategy blink;
SequenceCollection sequences;
LightCollection lights;

void setup() {
	sequences.add(&forward);
	sequences.add(&backward);
	lights.add(&toggle);
	lights.add(&blink);
	initLeds();
	interval.init(speedAnalogInput);
	buttonSequence.init(0, interruptButtonSequence);
	buttonLight.init(1, interruptButtonLight);
}

void initLeds(){
  for (int i = 0; i< NUMBER_OF_LEDS; i++){
    int port = LED_DISPLAY_STARTING_PORT + i;
    leds[i].init(port);
  }
}

void interruptButtonSequence() {
	sequences.cycle();
}

void interruptButtonLight() {
	lights.cycle();	
}

void loop() {
	SequenceStrategy * selectedSequenceBeforeIteration = sequences.getSelected();
	LightStrategy * selectedLightBeforeIteration = lights.getSelected();
	selectedSequenceBeforeIteration->iterate(
		leds, NUMBER_OF_LEDS, selectedLightBeforeIteration, &interval);  
}

