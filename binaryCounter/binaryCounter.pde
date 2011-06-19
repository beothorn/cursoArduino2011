#include <EEPROM.h>

#define BOARD_LED 13
#define ANALOG_MAX_VALUE 255

class Led{
  
  public:
  int port;
  
  void init(int _port){
    port = _port;
    prepareLed();
  }
  
  void turnOn (){
    digitalWrite(port, HIGH);
  }
  
  void turnOff(){
    digitalWrite(port, LOW);
  }
  
  private:
  
  void prepareLed(){
    pinMode(port, OUTPUT);
  }
  
};

class LedBinaryDisplay{
  #define NUMBER_OF_LEDS 6
  #define LED_DISPLAY_STARTING_PORT 3
  
  public:
  Led *leds[NUMBER_OF_LEDS];   
  
  LedBinaryDisplay(){
    initializeLeds();
  }
  
  void displayNumber(int number){
    for (int currentBit =0; currentBit< NUMBER_OF_LEDS; currentBit++){
       turnOnLedIfBitIsOn(currentBit, number);    
    }
  }
  
  void initializeLeds(){
     for (int i = 0; i< NUMBER_OF_LEDS; i++){
       leds[i] = (Led *) malloc(sizeof(Led));
       int port = LED_DISPLAY_STARTING_PORT + i;
       leds[i] -> init(port);
     }
  }
  
  private:
  void turnOnLedIfBitIsOn(int currentBit, int number){
      Led* led = leds[currentBit];
      
      if (isBitOn(number, currentBit))
        led -> turnOn();
      else 
        led -> turnOff();
  }
  
  boolean isBitOn(int value, int offset){
    return value & (1<<offset);
  }
};

class Button{
  boolean wasDown;
  boolean pressed;
  int times;
  int port;
  
  public:
  
  Button(int _port){
    port = _port;
    
    wasDown = false;
    times = 0;
    pinMode(port, INPUT);
  }
  
  void refreshState(){
     if (buttonIsDown()){
      wasDown = true;
      return;
     }
    
     if (wasDown){
      times++;
      pressed = true;
      wasDown = false;
    }
  }
  
  boolean buttonIsDown(){
    return digitalRead(port);
  }
  
  boolean wasPressed(){
    boolean oldvalue = pressed;
    pressed = false;
    return oldvalue;
  }
  
  int getTimesPressed(){
    return times;
  }
};

Button addOne = Button(2);
Button doubleNumber = Button(12);
LedBinaryDisplay ledDisplay = LedBinaryDisplay();

void setup(){
  number = EEPROM.read(42);
}

int number = 0;
void loop(){  
  
  addOne.refreshState();
  doubleNumber.refreshState();
  
  if (addOne.wasPressed()){
    number += 1;
  }
  
  if (doubleNumber.wasPressed()){
    number *=2;
  }
  
  ledDisplay.displayNumber(number);
  EEPROM.write(42, number);   
    
}




