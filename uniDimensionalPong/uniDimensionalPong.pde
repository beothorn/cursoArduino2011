//--Board constants

#define FIRST_LED_PORT 2
#define LAST_LED_PORT 11
#define DIAL_PORT 0
#define LIGHT_SENSOR_PORT 1
#define BUTTON1_PORT 12
#define BUTTON2_PORT 13
#define RANDOM_SOURCE_PORT 4

//--Game constants
#define WAIT_FOR_GAME_BEGIN 500
#define LEFT 1
#define RIGHT 0
#define STARTING_SPEED 400
#define ACCELERATION 100
#define MINIMUN_SPEED 40
#define BUTTON_PRESS_INTERVAL 50
#define BUTTON_REST_INTERVAL -100
#define BLINKING_TIME 5


#define TRUE 1
#define FALSE 0

int isReadingFromDial = FALSE;
int ballPosition = 0;
int ballLedSpeed = 0;
int ballDirection = LEFT;
long button1PressedStateTime = 0;
long button2PressedStateTime = 0;

void setLedIntervalTo(int beginLed,int endLed,int stateHIGGorLOW){
  for(int i=beginLed;i<=endLed;i++){;
    digitalWrite(i,stateHIGGorLOW);
  }
}

void setAllLedsTo(int stateHIGGorLOW){
  setLedIntervalTo(FIRST_LED_PORT,LAST_LED_PORT,stateHIGGorLOW);
}

void clearLeds(){
  setAllLedsTo(LOW);
}

int halfLedIndex(){
  return (LAST_LED_PORT+FIRST_LED_PORT)/2;
}

void lightOnLeds(){
  setAllLedsTo(HIGH);
}

void lightOnFirstHalfLeds(){
  setLedIntervalTo(FIRST_LED_PORT,halfLedIndex(),HIGH);
}

void lightOnSecondHalfLeds(){
  setLedIntervalTo(halfLedIndex(),LAST_LED_PORT,HIGH);
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
  randomSeed(analogRead(RANDOM_SOURCE_PORT));
  isReadingFromDial = FALSE;
  ballPosition = halfLedIndex();
  ballLedSpeed = STARTING_SPEED;
  if(random()%2)
    ballDirection = LEFT;
  else
    ballDirection = RIGHT;
  button1PressedStateTime = 0;
  button2PressedStateTime = 0;  
  displayBall();
  delay(WAIT_FOR_GAME_BEGIN);
}

void blinkFirstHalf(){
  for(int i=0;i<BLINKING_TIME;i++){
    clearLeds();
    delay(200);
    lightOnFirstHalfLeds();
    delay(200);
  }
}

void blinkSecondHalf(){
  for(int i=0;i<BLINKING_TIME;i++){
    clearLeds();
    delay(200);
    lightOnSecondHalfLeds();
    delay(200);
  }
}

void blinkWinner(){
  if(ballPosition==FIRST_LED_PORT){
    blinkSecondHalf();
  }else{
    blinkFirstHalf();
  }
}

void gameOver(){
  blinkWinner();
  resetValues();
}

void giveAChance(){
  delay(ballLedSpeed);
}

int isButton1Pressed(){
  return button1PressedStateTime > 0;
}

int isButton2Pressed(){
  return button2PressedStateTime > 0;
}

int isButtonPressed(int button){
  if(button == BUTTON1_PORT){
    return isButton1Pressed();
  }
  return isButton2Pressed();
}

void testBallForBorderConditionsAndTakeAction(int positionToTest,int button,int newDirectionIfPressed){
  if(ballPosition == positionToTest){
    displayBall();
    giveAChance();
    if(isButtonPressed(button)){
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

void readButtons(){
  if(digitalRead(BUTTON1_PORT)){
    if(button1PressedStateTime==0){
      button1PressedStateTime = BUTTON_PRESS_INTERVAL;
    }
  }
  if(digitalRead(BUTTON2_PORT)){
    if(button2PressedStateTime==0){
      button2PressedStateTime = BUTTON_PRESS_INTERVAL;
    }
  }
  
  int b1ShouldRest = FALSE;
  if(button1PressedStateTime > 0){
    button1PressedStateTime--;
    b1ShouldRest = TRUE;
  }
  
  int b2ShouldRest = FALSE;
  if(button2PressedStateTime > 0){
    button2PressedStateTime--;
    b2ShouldRest = TRUE;
  }
  
  if(button1PressedStateTime == 0 && b1ShouldRest){
    b1ShouldRest = FALSE;
    button1PressedStateTime = BUTTON_REST_INTERVAL;
  } 
  if(button2PressedStateTime == 0 && b2ShouldRest){
    b2ShouldRest = FALSE;
    button2PressedStateTime = BUTTON_REST_INTERVAL;
  }
  
  if(button1PressedStateTime < 0)
    button1PressedStateTime++;
  if(button2PressedStateTime < 0)
    button2PressedStateTime++;
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
  readButtons();
  moveBall();
  displayBall();
  testForCollisionWithBorders();
  delay(ballLedSpeed);
}
