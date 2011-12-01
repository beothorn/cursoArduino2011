class Dial{

public:
  Dial(int aPin){
    pin = aPin;
    pinMode(aPin, INPUT);
  }

  int readByte(){
    int input = analogRead(pin);
    return map(input, 0, 1023, 0, 255 );

  }

private:

int pin;	
	
};
