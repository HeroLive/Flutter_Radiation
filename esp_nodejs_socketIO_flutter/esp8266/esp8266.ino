#include <Arduino.h>
#include "DHT.h"
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <WiFiManager.h>         //https://github.com/tzapu/WiFiManager

#include <SocketIoClient.h> //v0.3 fix error beginSSL by replace const char* fingerprint = DEFAULT_FINGERPRINT to const uint8_t * fingerprint = NULL

#include <WiFiUdp.h> //realtime
#include <NTPClient.h> //realtime

ESP8266WiFiMulti WiFiMulti;
SocketIoClient socketIO;

//properties realtime from internet: vn.pool.ntp.org
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "vn.pool.ntp.org");

//char host[] = "192.168.1.3";
//int port = 3484;
char host[] = "dht-led.glitch.me";
int port = 80;
char username[] = "esp";
char password[] = "1234";

uint64_t messageTimestamp;

#define BtD5 14
#define DHT11Pin D1
#define DHTType DHT11
DHT HT(DHT11Pin, DHTType);
double humi;
double tempC;
double tempF;
long count = 0;
unsigned long epochTime;
StaticJsonDocument<200> SensorDoc;
StaticJsonDocument<500> LedDoc;


void setup() {
  Serial.begin(115200);

  //WiFiManager
  //Local intialization. Once its business is done, there is no need to keep it around
  WiFiManager wifiManager;
  //reset saved settings
  //  wifiManager.resetSettings();

  //set custom ip for portal
  wifiManager.setAPStaticIPConfig(IPAddress(10, 0, 1, 1), IPAddress(10, 0, 1, 1), IPAddress(255, 255, 255, 0));

  //fetches ssid and pass from eeprom and tries to connect
  //if it does not connect it starts an access point with the specified name
  //here  "AutoConnectAP"
  //and goes into a blocking loop awaiting configuration
  wifiManager.autoConnect(username, password);
  //or use this for auto generated name ESP + ChipID
  //wifiManager.autoConnect();
  //if you get here you have connected to the WiFi
  Serial.println("connected...yeey :)");

  socketIO.begin(host, port);
  // use HTTP Basic Authorization this is optional remove if not needed
  //  socketIO.setAuthorization("username", "password");

  pinMode(BtD5, INPUT_PULLUP);

  HT.begin();
  delay(1000);
  dht();
  socketIO.on("server2gpio", GpioEvent);
  //Realtime setup
  timeClient.begin();
  timeClient.setTimeOffset(7 * 3600); //Vietnam Timezone
}

void loop() {
  epochTime = getTime();
  socketIO.loop();
  if (millis() - messageTimestamp > 5000) {
    messageTimestamp = millis();
    count++;
    dht();
  }
  buttonAction();
}

//received data refer to esp_nodejs_socketIO_flutter
void GpioEvent(const char * payload, size_t length) {
  //  Serial.println(payload);
  deserializeJson(LedDoc, payload);
  serializeJson(LedDoc, Serial);
  Serial.println("Received data from server");

  for (int i = 0; i < LedDoc["gpio"].size(); i++) {
    pinMode(LedDoc["gpio"][i]["pin"], OUTPUT);
    digitalWrite(LedDoc["gpio"][i]["pin"], LedDoc["gpio"][i]["value"]);
  }
}
void buttonAction() {
  if (digitalRead(BtD5) == 0) {
    while (digitalRead(BtD5) == 0);
    pinMode(LedDoc["gpio"][0]["pin"], OUTPUT);
    LedDoc["gpio"][0]["value"] = !LedDoc["gpio"][0]["value"];
    digitalWrite(LedDoc["gpio"][0]["pin"], LedDoc["gpio"][0]["value"]);
    
    char msg[256];
    serializeJson(LedDoc, msg);
    socketIO.emit("gpio2Server", msg);
  }
}
void dht() {
  humi = HT.readHumidity();
  tempC = HT.readTemperature();
  tempF = HT.readTemperature(true);
  Serial.println(humi);
  SensorDoc["dht"]["tempC"] = tempC;
  SensorDoc["dht"]["humi"] = humi;
  SensorDoc["dht"]["count"] = count;
  SensorDoc["dht"]["date"] = epochTime;
  char msg[256];
  serializeJson(SensorDoc, msg);
  socketIO.emit("sensor2Server", msg);
}

// Function that gets current epoch time
unsigned long getTime() {
  timeClient.update();
  unsigned long now = timeClient.getEpochTime();
  return now;
}
