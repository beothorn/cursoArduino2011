#ifndef SequenceStrategy_h
#define SequenceStrategy_h

#include "LedList.h"
#include "LightStrategy.h"
#include "DelayIntervalReader.h"

class SequenceStrategy {
public:
	virtual void iterate(LedList * leds, 
		LightStrategy * light, DelayIntervalReader * interval);
};

#endif
