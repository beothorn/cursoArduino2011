#include "Button.h"

void Button::init(int port, void (*userFunc)(void)) {
	attachInterrupt(port, userFunc, RISING);
}

