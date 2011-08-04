//////// LED //////// 

class Led {
  int pin;
  boolean state;

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

  void on() {
    digitalWrite(pin, HIGH);
    state = true;
  }

  void off() {
    digitalWrite(pin, LOW);
    state = false;
  }

};

//////// LED PANEL //////// 

const int LED_DISPLAY_STARTING_PORT = 4;
const int NUMBER_OF_LEDS = 4; // 10

class LedPanel {

  Led *leds[NUMBER_OF_LEDS];

public:

  void init() {
    mallocLeds();
  }

  void mallocLeds(){
    for (int i = 0; i< NUMBER_OF_LEDS; i++){
      leds[i] = (Led *) malloc(sizeof(Led));
      int port = LED_DISPLAY_STARTING_PORT + i;
      leds[i] -> init(port);
    }
  }

  Led* getLed(int i) {
    return leds[i];
  }
  
  int getCount() {
    return NUMBER_OF_LEDS;
  }
};


//////// MAIN //////// 

const int lightPin = A0;
const int START_OF_DARKNESS = 600;
const int END_OF_DARKNESS   = 950;

LedPanel *panel;

void setup() {
  Serial.begin(9600);
  panel = (LedPanel *) malloc(sizeof(LedPanel));
  panel -> init();
}

void loop() {
  int numberOfLeds = panel -> getCount();
  int lightValue = analogRead(lightPin);
  int sensorValue = lightValue;  
  int darkness = calculateDarkness(sensorValue, numberOfLeds);
  iterate(numberOfLeds, darkness);
}

int calculateDarkness(int sensorValue, int numberOfLeds) {
  int darknessRange = END_OF_DARKNESS - START_OF_DARKNESS;
  int darknessStep = darknessRange / numberOfLeds;
  int measured = sensorValue - START_OF_DARKNESS;
  int darkness = measured / darknessStep;
  Serial.println(darkness, DEC);
  return darkness;
}
  
void iterate(int numberOfLeds, int darkness) {
  for (int i = 0; i < numberOfLeds; i++)  {
    Led *led = panel -> getLed(i);
    if (i < darkness)
      led -> on(); 
    else led -> off();
  }
}


