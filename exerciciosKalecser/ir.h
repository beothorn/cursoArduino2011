#include <IRremote.h>
#include <IRremoteInt.h>

class IrReceiver{

public:

  IrReceiver(int aPin){
    pin = aPin;
    Serial.begin(9600);
  }

  long receive(){
    decode_results results;
    IRrecv rec = IRrecv(pin);
    rec.enableIRIn();

    while (!rec.decode(&results)){
    }
    return results.value;
  }

private:
int pin;

};
