class Led {
  int pin;
  boolean state;

  void on() {
    digitalWrite(pin, HIGH);
    state = true;
  }

  void off() {
    digitalWrite(pin, LOW);
    state = false;
  }

private:

  void pinModeOutput(){
    pinMode(pin, OUTPUT);
  }

public :

  void init(int _pin){
    pin = _pin;
    pinModeOutput();
  }

  void toggle() {
    if (state) off(); 
    else on();
  } 

};

