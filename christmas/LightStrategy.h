#ifndef LightStrategy_h
#define LightStrategy_h


#include "Led.h"

class LightStrategy {
public:
	virtual void light(Led * led);
};


#endif
