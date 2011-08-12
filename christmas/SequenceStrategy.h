#ifndef SequenceStrategy_h
#define SequenceStrategy_h

#include "LightStrategy.h"
#include "DelayIntervalReader.h"

class SequenceStrategy {
public:
	virtual void iterate(Led leds[], int numberOfLeds, 
		LightStrategy * light, DelayIntervalReader * interval);
};

#endif
