#include <Arduino.h>
#include "DHT.h"
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <WiFiManager.h>         //https://github.com/tzapu/WiFiManager

#include <SocketIoClient.h> //v0.3 fix error beginSSL by replace const char* fingerprint = DEFAULT_FINGERPRINT to const uint8_t * fingerprint = NULL


ESP8266WiFiMulti WiFiMulti;
SocketIoClient socketIO;

char host[] = "192.168.1.3";
int port = 3484;
//char host[] = "enchanting-cut-wilderness.glitch.me";
//int port = 80;
char username[] = "esp";
char password[] = "1234";

uint64_t messageTimestamp;

#define BtD5 14
#define DHT11Pin D1
#define DHTType DHT11
DHT HT(DHT11Pin, DHTType);
float humi;
float tempC;
float tempF;
long count = 0;
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

  HT.begin();
  dht();
  socketIO.on("server2gpio", GpioEvent);
}

void loop() {
  socketIO.loop();
  uint64_t now = millis();
  if (now - messageTimestamp > 5000) {
    messageTimestamp = now;
    count++;
    dht();
  }
}

//received data refer to esp_nodejs_socketIO_flutter
void GpioEvent(const char * payload, size_t length) {
  Serial.println(payload);
  deserializeJson(LedDoc, payload);
  serializeJson(LedDoc, Serial);
  Serial.println("Received data from server");

  for (int i = 0; i < LedDoc["gpio"].size(); i++) {
    pinMode(LedDoc["gpio"][i]["pin"], OUTPUT);
    digitalWrite(LedDoc["gpio"][i]["pin"], LedDoc["gpio"][i]["value"]);
  }
}
void dht() {
  humi = HT.readHumidity();
  tempC = HT.readTemperature();
  tempF = HT.readTemperature(true);
  SensorDoc["dht"]["tempC"] = round(tempC);
  SensorDoc["dht"]["humi"] = round(humi);
  SensorDoc["dht"]["count"] = count;
  char msg[256];
  serializeJson(SensorDoc, msg);
  socketIO.emit("sensor2Server", msg);
}
