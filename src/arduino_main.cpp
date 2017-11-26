#include <Arduino.h>

void setup()
{
  Serial.begin(115200);
  
  pinMode(LED_BUILTIN, OUTPUT);
}


void loop() {
	Serial.println("LED on");
  digitalWrite(LED_BUILTIN, HIGH);
	delay(3000);

	Serial.println("LED off");
  digitalWrite(LED_BUILTIN, LOW);
	delay(3000);
}
