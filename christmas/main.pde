const int buttonPin = 2;
const int speedAnalogInput = A0;
const int LED_DISPLAY_STARTING_PORT = 4;
const int NUMBER_OF_LEDS = 4; // 10;


Led *leds[NUMBER_OF_LEDS];

void setup() {
  mallocLeds();
  attachInterrupt(0, buttonPressed, CHANGE);
}

void mallocLeds(){
  for (int i = 0; i< NUMBER_OF_LEDS; i++){
    leds[i] = (Led *) malloc(sizeof(Led));
    int port = LED_DISPLAY_STARTING_PORT + i;
    leds[i] -> init(port);
  }
}

boolean buttonState;

void buttonPressed() {
  buttonState = !buttonState;
}

void loop() {
  boolean buttonStateBeforeIteration = buttonState;
  boolean forward = buttonStateBeforeIteration;
  iterate(forward);  
}
  
void iterate(boolean forward) {
  for (int i = 0; i < NUMBER_OF_LEDS; i++) 
  {
  	toggleNextLed(i, forward);
  	delayIntervalFromSpeedAnalogInput();
  }
}

void toggleNextLed(int i, int forward) {
    int nextLed = determineNextLed(i, forward);
	leds[nextLed]->toggle();
}

int determineNextLed(int step, boolean forward) {
    if (forward)
      return step;

    return NUMBER_OF_LEDS - step - 1;
}

void delayIntervalFromSpeedAnalogInput() {
    int sensorValue = analogRead(speedAnalogInput);
    int interval = sensorValue;
	delay(interval);
}
