#include "SequenceCollection.h"

void SequenceCollection::add(SequenceStrategy * element) {
	this->elements[size] = element;
	this->size++;
}

void SequenceCollection::cycle() {
	if (selection == (size - 1)) 
		selection = 0;
	else 
		selection++;
}

SequenceStrategy * SequenceCollection::getSelected() {
	return elements[selection];
}



