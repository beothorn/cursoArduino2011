#define FIRST_LED_PORT 2
#define LAST_LED_PORT 11
#define DIAL_PORT 0
#define LIGHT_SENSOR_PORT 1
#define BUTTON1_PORT 12
#define BUTTON2_PORT 13
#define LEFT 1
#define RIGHT 0
#define ACCELERATION 100
#define MINIMUN_SPEED 40
#define TRUE 1
#define FALSE 0

int isReadingFromDial = FALSE;
int ballPosition = 0;
int ballLedSpeed = 0;
int ballDirection = LEFT;

void setAllLedsTo(int stateHIGGorLOW){
  for(int i=FIRST_LED_PORT;i<=LAST_LED_PORT;i++){;
    digitalWrite(i,stateHIGGorLOW);
  }
}

void clearLeds(){
  setAllLedsTo(LOW);
}

void lightOnLeds(){
  setAllLedsTo(HIGH);
}

void displayBall(){
  clearLeds();
  digitalWrite(ballPosition,HIGH);
}

void moveBall(){
  if(ballDirection == LEFT)
    ballPosition--;
  else
    ballPosition++;
}

void resetValues(){
  isReadingFromDial = 0;
  ballPosition = 8;//(LAST_LED_PORT-FIRST_LED_PORT)/2;
  ballLedSpeed = 400;
  ballDirection = LEFT;
}

void blinkAll(int times){
  for(int i=0;i<times;i++){
    clearLeds();
    delay(200);
    lightOnLeds();
    delay(200);
  }
}

void gameOver(){
  blinkAll(3);
  resetValues();
}

void giveAChance(){
  delay(ballLedSpeed);
}

void testBallForBorderConditionsAndTakeAction(int positionToTest,int button,int newDirectionIfPressed){
  if(ballPosition == positionToTest){
    displayBall();
    giveAChance();
    if(digitalRead(button)){
      ballDirection = newDirectionIfPressed;
      ballLedSpeed -= ACCELERATION;
      if(ballLedSpeed<MINIMUN_SPEED)
        ballLedSpeed = MINIMUN_SPEED;
    }else{
      gameOver();
    }
  }
}

void testForCollisionWithBorders(){
  testBallForBorderConditionsAndTakeAction(FIRST_LED_PORT,BUTTON1_PORT,RIGHT);
  testBallForBorderConditionsAndTakeAction(LAST_LED_PORT,BUTTON2_PORT,LEFT);
}

void setup()
{
  for(int i=FIRST_LED_PORT;i<=LAST_LED_PORT;i++){
    pinMode(i, OUTPUT);
  }
  pinMode(BUTTON1_PORT, INPUT);
  pinMode(BUTTON2_PORT, INPUT);
  resetValues();
}

void loop()
{
  moveBall();
  displayBall();
  testForCollisionWithBorders();
  delay(ballLedSpeed);
}
