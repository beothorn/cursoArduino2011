#include "base.h"
#include <IRremote.h>
#include <IRremoteInt.h>

class IrReceiver{

public:

  IrReceiver(int aPin){
    receiver = new IRrecv(aPin);
    receiver->enableIRIn();
  }

  virtual ~IrReceiver(){
    delete receiver;
  }

  long waitForCommand(){
    decode_results results;

    while (!receiver->decode(&results)){
    }
    receiver->resume();
    return results.value;
  }


private:
IRrecv * receiver;

};
