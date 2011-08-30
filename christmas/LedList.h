#include "Led.h"

class LedList {
public:
	void add(Led * element);
	Led * get(int index);
	int size();
private:
	Led * elements[10];
	int _size;
};


