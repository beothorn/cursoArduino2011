#define FIRST_LED_PORT 2
#define LAST_LED_PORT 11
#define DIAL_PORT 0
#define LIGHT_SENSOR_PORT 1
#define BUTTON1_PORT 12
#define BUTTON2_PORT 13
#define TRUE 1
#define FALSE 0

int isReadingFromDial = 0;

void displayNumber(int number){
  int bitMask = 1;
  for(int i=FIRST_LED_PORT;i<=LAST_LED_PORT;i++){
    int shouldTurnLedOnThisBitToHigh = number & bitMask;
    digitalWrite(i,shouldTurnLedOnThisBitToHigh);
    number = number >> 1;
  }
}

void displayLightSensor(){
  displayNumber(analogRead(LIGHT_SENSOR_PORT));
}

void displayDial(){
  int bitsToDiscard = 3;
  int valueToDisplay = analogRead(DIAL_PORT)>>bitsToDiscard;
  displayNumber(valueToDisplay);
}

void displayValue(){
  if(isReadingFromDial)
    displayDial();
  else
    displayLightSensor();
}

void readButtonsAndChangeState(){
  if(digitalRead(BUTTON1_PORT))
    isReadingFromDial = 1;
  if(digitalRead(BUTTON2_PORT))
    isReadingFromDial = 0;
}

void setup()
{
  for(int i=FIRST_LED_PORT;i<=LAST_LED_PORT;i++){
    pinMode(i, OUTPUT);
  }
  pinMode(BUTTON1_PORT, INPUT);
  pinMode(BUTTON2_PORT, INPUT);
}

void loop()
{
  readButtonsAndChangeState();
  displayValue();  
}
