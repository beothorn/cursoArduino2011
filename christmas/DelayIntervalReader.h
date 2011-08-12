class DelayIntervalReader {
public:
	void init(int _pin);
	int read();
	
private:
	int pin;
};
