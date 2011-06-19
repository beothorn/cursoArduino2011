#define FIRST_LED_PORT 2
#define LAST_LED_PORT 8
#define DIAL_PORT 0
#define TRUE 1
#define FALSE 0

void displayNumber(int number){
  int bitMask = 1;
  for(int i=FIRST_LED_PORT;i<=LAST_LED_PORT;i++){
    int shouldTurnLedOnThisBitToHigh = number & bitMask;
    digitalWrite(i,shouldTurnLedOnThisBitToHigh);
    number = number >> 1;
  }
}

void setup()
{
  for(int i=FIRST_LED_PORT;i<=LAST_LED_PORT;i++){
    pinMode(i, OUTPUT);
  }
}

int readDiscardingToUnstableBits(){
  return analogRead(DIAL_PORT)>>3;
}

void loop()
{
  displayNumber(readDiscardingToUnstableBits());
}
