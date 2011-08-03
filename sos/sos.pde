int timeunitMilliseconds = 100;

int ledOnboard = 13;
int ledDigital = 12;
int ledAnalog  = 11;

int analogBrightness = 2; // 255 max

void setup()
{
  pinMode(ledOnboard, OUTPUT);      
  pinMode(ledDigital, OUTPUT);      
  pinMode(ledAnalog, OUTPUT);      
}

void loop()
{
  s();
  o();
  s();
  stop(1);
}

void s() {
  blink();
  stop(1);
  blink();
  stop(1);
  blink();
  stop(3);
}

void o() {
  blink();
  stop(3);
  blink();
  stop(3);
  blink();
  stop(3);
}

void blink() {
	on();
	stop(1);
	off();
}

void on() {
  digitalWrite(ledOnboard, HIGH);
  digitalWrite(ledDigital, HIGH);
  analogWrite(ledAnalog, analogBrightness);
}

void off() {
  digitalWrite(ledOnboard, LOW);
  digitalWrite(ledDigital, LOW);
  analogWrite(ledAnalog, 0);
}

void stop(int n) {
  delay(n * timeunitMilliseconds);
}
