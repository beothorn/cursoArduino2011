#ifndef Led_h
#define Led_h


#include <WProgram.h> 

class Led {

public :

	void init(int _pin);
	void on();
	void off();
	void toggle();
	void blink();
	

private:

  int pin;
  boolean state;

  void pinModeOutput();
  
};


#endif
