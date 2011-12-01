#include "SequenceStrategy.h"

class SequenceCollection {
public:
	void add(SequenceStrategy * element);
	void cycle();
	SequenceStrategy * getSelected();
private:
	SequenceStrategy * elements[10];
	int selection;
	int size;
};


