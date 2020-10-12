//EGO
//R+F+A
//MAD10
//Marzo 2011
//v3, 23/03/2011

int pwPin4=4;
int pwPin2=2;
int pwPin7=7;
long pulse4,inches4,cm4;
long pulse2,inches2,cm2;
long pulse7,inches7,cm7;

int transistorBasePin6=6;
int transistorBasePin5=5;
int transistorBasePin3=3;

int umbralLowSensorPin4=15;//cm
int umbralMediumSensorPin4=100;//cm
int umbralHighSensorPin4=200;//cm
int umbralLowRemapSensorPin4=0;//0 Volts
int umbralHighRemapSensorPin4=255;//5 Volts

int umbralLowSensorPin2=15;//cm
int umbralMediumSensorPin2=100;//cm
int umbralHighSensorPin2=200;//cm
int umbralLowRemapSensorPin2=0;//0 Volts
int umbralHighRemapSensorPin2=255;//5 Volts

int umbralLowSensorPin7=15;//cm
int umbralMediumSensorPin7=100;//cm
int umbralHighSensorPin7=200;//cm
int umbralLowRemapSensorPin7=0;//0 Volts
int umbralHighRemapSensorPin7=255;//5 Volts

int intensidadPorDefecto=200;


int pendienteSensorPin4=(umbralHighRemapSensorPin4-umbralLowRemapSensorPin4)/(umbralLowSensorPin4-umbralHighSensorPin4);
int pendienteSensorPin2=(umbralHighRemapSensorPin2-umbralLowRemapSensorPin2)/(umbralLowSensorPin2-umbralHighSensorPin2);
int pendienteSensorPin7=(umbralHighRemapSensorPin7-umbralLowRemapSensorPin7)/(umbralLowSensorPin7-umbralHighSensorPin7);


void setup() {
  Serial.begin(9600);  
}

void loop() {

  pulse4 = pulseIn(pwPin4, HIGH);
  inches4 = pulse4/147;
  cm4 = inches4 * 2.54;

  pulse2 = pulseIn(pwPin2, HIGH);
  inches2 = pulse2/147;
  cm2 = inches2 * 2.54;

  pulse7 = pulseIn(pwPin7, HIGH);
  inches7 = pulse7/147;
  cm7 = inches7 * 2.54;

  if(cm4 >= umbralLowSensorPin4 && cm4 <= umbralMediumSensorPin4){
    cm4=(umbralHighRemapSensorPin4+pendienteSensorPin4*(cm4-umbralLowSensorPin4))/1;
  } else if(cm4 > umbralMediumSensorPin4 && cm4 <= umbralHighSensorPin4){
    cm4=(umbralHighRemapSensorPin4+pendienteSensorPin4*(cm4-umbralLowSensorPin4))/3;
  } else {
    cm4=0;
  }
  
  if(cm2 >= umbralLowSensorPin2 && cm2 <= umbralMediumSensorPin2){
    cm2=umbralHighRemapSensorPin2+pendienteSensorPin2*(cm2-umbralLowSensorPin2);
  } else if(cm2 > umbralMediumSensorPin2 && cm2 <= umbralHighSensorPin2){
    cm2=(umbralHighRemapSensorPin2+pendienteSensorPin2*(cm2-umbralLowSensorPin2))/3;
  } else {
    cm2=0;
  }

  if(cm7 >= umbralLowSensorPin7 && cm7 <= umbralMediumSensorPin7){
    cm7=umbralHighRemapSensorPin7+pendienteSensorPin7*(cm7-umbralLowSensorPin7);
  } else if(cm7 > umbralMediumSensorPin7 && cm7 <= umbralHighSensorPin7){
    cm7=(umbralHighRemapSensorPin7+pendienteSensorPin7*(cm7-umbralLowSensorPin7))/3;
  } else {
    cm7=0;
  }


  //if(cm4==0 && cm2==0 && cm7==0){
  //  analogWrite(transistorBasePin5,intensidadPorDefecto);
  //} else {
    analogWrite(transistorBasePin6,cm4);
    analogWrite(transistorBasePin5,cm2);
    analogWrite(transistorBasePin3,cm7);
  //}

  
  
 Serial.print("Map sensor pin #4: ");
 Serial.print(cm4);
 Serial.println("");



  //delay(200);

}
