#include "LightCollection.h"

void LightCollection::add(LightStrategy * element) {
	this->elements[size] = element;
	this->size++;
}

void LightCollection::cycle() {
	if (selection == (size - 1)) 
		selection = 0;
	else 
		selection++;
}

LightStrategy * LightCollection::getSelected() {
	return elements[selection];
}



