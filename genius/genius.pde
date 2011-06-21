#include <WProgram.h>

#include "common.h"
#include "led.h"
#include "button.h"
#include "genius.h"
#include "buzzer.h"


#define LED_COUNT 4

Led gameLeds[LED_COUNT] = { Led(5), Led(6), Led(9), Led(10) };
Button gameButtons[LED_COUNT] = { Button(7), Button(8), Button(13), Button(12)};
int buttonCount = LED_COUNT;

Genius game(gameLeds, gameButtons, buttonCount);

Buzzer buzzer = Buzzer(11);
Button increaseFreq(7);
Button decreaseFreq(8);

long frequencyChangeInterval = 1000;
long currentFrequency = 100;

void setup()
{ 
  buzzer.playTone(15000, frequencyChangeInterval);
}

void loop()
{ 
  if (increaseFreq.wasPushed()) {
    currentFrequency+=1000;
    buzzer.playTone(currentFrequency, frequencyChangeInterval);
  }
  if (decreaseFreq.wasPushed()) {
    currentFrequency-=1000;
    buzzer.playTone(currentFrequency, frequencyChangeInterval);
  }  
  
  buzzer.tick();     
  

  
}
