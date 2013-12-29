#ifndef Button_h
#define Button_h


#include <Arduino.h> 

class Button {
public:
	void init(int port, void (*userFunc)(void));
};


#endif
