class Led {
public:
  Led(int ledPin) {
    this->ledPin = ledPin;
    prepare();
  }
  
  void prepare() {
    pinMode(ledPin,OUTPUT);
  }
  
  void turnOn() {
     isOn = true;
     digitalWrite(ledPin, HIGH);
  }
  
  void turnOff() {
    isOn = false;
    digitalWrite(ledPin, LOW);
  }

  void dimmTo(int power){
    analogWrite(ledPin, power);
  }
  
  long ledOnExpirationTime;
  void turnOnAndHoldUntilExpired(int timeToHold) {
    turnOn();
    ledOnExpirationTime = millis() + timeToHold;  
  }

  void turnOffIsTimeExpired() {
    if (millis() < ledOnExpirationTime) 
      return;
    turnOff();    
  }

  void switchState(){
    if (isOn){
      turnOff();
    } else {
      turnOn();
    }
  }

private:
  int ledPin;
  bool isOn;
};

