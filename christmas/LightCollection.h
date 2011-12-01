#include "LightStrategy.h"

class LightCollection {
public:
	void add(LightStrategy * element);
	void cycle();
	LightStrategy * getSelected();
private:
	LightStrategy * elements[10];
	int selection;
	int size;
};


