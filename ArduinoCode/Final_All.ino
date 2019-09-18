//Example_12_LCD_16x2 
#include <LiquidCrystal.h>
LiquidCrystal lcd(9, 8, 7, 6, 5, 4);
#include <SoftwareSerial.h>// import the serial library
#include <Servo.h>
#include <Password.h>
#include <Keypad.h>

Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards

int pos = 0;    // variable to store the servo position
int opc =0;
int clc =0;
SoftwareSerial blue(11, 10); // TX, RX
int ledpinR1=13; // led on D13 will show blink on / off
int BluetoothData; // the data given from Computer
int pushButton=2;
int ledpinR2=12;
int     right =0;

Password password = Password( "1234" );
const byte ROWS = 4; // Four rows
const byte COLS = 4; // Four columns
// Define the Keymap
char keys[ROWS][COLS] = {
  {
    '1','2','3','A',  }
  ,
  {
    '4','5','6','B',  }
  ,
  {
    '7','8','9','C',  }
  ,
  {
    '*','0','#','D',  }
};
// Connect keypad ROW0, ROW1, ROW2 and ROW3 to these Arduino pins.
byte rowPins[ROWS] = {22, 24, 26, 28}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {23, 25, 27, 29}; //connect to the column pinouts of the keypad

// Create the Keypad
Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );



void setup() {
  lcd.begin(16, 2);
 // lcd.print("hello, world!");
 // Serial.begin(9600);
  blue.begin(9600);
 // blue.println("Bluetooth On please press 1 or 0 blink LED ..");
  pinMode(ledpinR1,OUTPUT);
  pinMode(ledpinR2,OUTPUT);
  pinMode(pushButton,INPUT);
    myservo.attach(3);  // attaches the servo on pin 9 to the servo object
      myservo.write(0);              // tell servo to go to position in variable 'pos'
keypad.setDebounceTime(50);
  displayCodeEntryScreen();
  keypad.addEventListener(keypadEvent);

}

void displayCodeEntryScreen()
{
  password.reset();
  lcd.clear();
  lcd.setCursor(2, 0);
  lcd.print("Enter Code:");
  lcd.setCursor(0,1);
  keypad.addEventListener(keypadEvent); //add an event listener for this keypad
  //setup and turn off both LEDs
  }


void loop() {

    keypad.getKey();
 while( right == 1){

    BluetoothData=blue.read();
    if(BluetoothData=='1'){
      lcd.clear();
      lcd.print("Light of Room1");
      lcd.setCursor(0, 1);
      lcd.print("is now open");
      digitalWrite(ledpinR1,1);
      delay(4000);
      lcd.clear();

    }
    else if(BluetoothData=='2'){
      lcd.clear();
      lcd.print("Light of Room1");
      lcd.setCursor(0, 1);
      lcd.print("is now closed");
      digitalWrite(ledpinR1,0);
      delay(4000);
            lcd.clear();

    }
    else if(BluetoothData=='3'){
      lcd.clear();
      lcd.print("Light of Room2");
      lcd.setCursor(0, 1);
      lcd.print("is now open");
      digitalWrite(ledpinR2,1);
      delay(4000);
        lcd.clear();

    }
    else if(BluetoothData=='4'){
      lcd.clear();
      lcd.print("Light of Room2");
      lcd.setCursor(0, 1);
      lcd.print("is now closed");
      digitalWrite(ledpinR2,0);
      delay(4000);
       lcd.clear();

    }
  

    else if(BluetoothData=='5' ){
      if(opc == 0){
      lcd.clear();
      lcd.print("Door is Opened");
      for (pos = 0; pos <= 90; pos += 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
          myservo.write(pos);              // tell servo to go to position in variable 'pos'
          delay(25);                       // waits 15ms for the servo to reach the position
      }
      delay(3000);
         lcd.clear();
      opc =1;
      clc =0;
    }
    else
    {
      lcd.clear();
      lcd.print("Door is Opened");
      delay(2000);
      lcd.clear();
    }
    }
    else if(BluetoothData=='6'){
      if (clc ==0){
      lcd.clear();
      lcd.print("Door is Closed");
      for (pos = 90; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(25);  
    // waits 15ms for the servo to reach the position
    clc = 1;
    opc =0;
  }
      delay(3000);
         lcd.clear();

    }
    else{
      lcd.clear();
      lcd.print("Door is Closed");
      delay(2000);
      lcd.clear();
    }
  
    }
    else{
      lcd.setCursor(0, 0);
      lcd.print("Waiting for");
      lcd.setCursor(0, 1);
      lcd.print("your order");

    }

}
}
void keypadEvent(KeypadEvent eKey){
  switch (keypad.getState()){
  case PRESSED:
    lcd.print(eKey);
    switch (eKey){
    case 'D': 
      checkPassword();
      break;
    case '*': 
         displayCodeEntryScreen(); break;
    default:
      password.append(eKey);
    }
  }
}

int checkPassword(){
  if (password.evaluate()){
    lcd.clear();
    delay(30);
    lcd.setCursor(1, 0);
    lcd.print("Right Password");
    lcd.setCursor(4, 1);
    lcd.print("Welcome");
    delay(2500);
          lcd.clear();

    //displayCodeEntryScreen();
    return right =1;
    
  }
  else{
    loop(); {
      //redlight();
    }
    lcd.clear();
    delay(10);
    lcd.setCursor(2, 0);
    lcd.print("Wrong Password");
    delay(2500);
    lcd.clear();
    displayCodeEntryScreen();
        right =0;

  }
}



  
