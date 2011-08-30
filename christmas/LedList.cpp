#include "LedList.h"

void LedList::add(Led * element) {
	this->elements[_size] = element;
	this->_size++;
}

Led * LedList::get(int index) {
	return elements[index];
}

int LedList::size() {
	return this->_size;
}


