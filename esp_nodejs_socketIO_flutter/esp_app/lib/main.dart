import 'dart:convert';

import 'package:esp_app/dht.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import './sensor.dart';
import './gpio.dart';
import './pin.dart';
import './dataModel.dart';
import 'package:realm/realm.dart';

void main() {
  runApp(const MyApp());
}

IO.Socket socket = IO.io(
    'https://dht-led.glitch.me', //'http://192.168.1.3:3484',, //https://jelly-plume-cupcake.glitch.me
    IO.OptionBuilder().setTransports(['websocket']).build());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Smart Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Sensor _sensorData = Sensor(Dht(0, 0, 0, 0));
  List<Gpio> gpios = [Gpio(4, 'D2', true), Gpio(16, 'D0', false)];
  late Realm realm;
  @override
  void initState() {
    // TODO: implement initState
    final config = Configuration([RDht.schema]);
    realm = Realm(config);
    super.initState();
    connectAndListen();
  }

  void connectAndListen() {
    print('Call func connectAndListen');

    socket.onConnect((_) {
      print('connect');
      socket.emit('from-user', 'test from user');
    });

    socket.on('server2user', (data) {
      print(data);
      var sensor = Sensor.fromJson(data);
      // print(sensor);
      print('Nhiet do: ${sensor.dht.tempC} Do am: ${sensor.dht.humi}');

      setState(() {
        _sensorData = sensor;
      });
      DBJob(sensor);
    });
    socket.on('server2gpio', (data) {
      print(data);
    });
    socket.on('gpio-server-user', (data) {
      print(data);
      var pin = Pin.fromJson(data);
      setState(() {
        gpios = pin.gpio;
      });
    });

    //When an event recieved from server, data is added to the stream
    socket.onDisconnect((_) => print('disconnect'));
  }

  void sendGpioToServer(Gpio gpio) {
    if (gpio.pin == null) {
      return;
    }
    var _value = gpio.value != null ? !gpio.value : gpio.value;
    final _gpio = gpios.firstWhere((element) => element.pin == gpio.pin);
    if (_gpio != null) {
      setState(() => _gpio.value = _value);
    }
    var msg = {"gpio": gpios};
    socket.emit('button-to-server', jsonEncode(msg));
  }

  void DBJob(Sensor sensor) {
    var _dht = RDht(
        sensor.dht.tempC, sensor.dht.humi, sensor.dht.count, sensor.dht.date);
    realm.write(() {
      realm.add(_dht);
    });
    print("Getting all dht data from the Realm.");
    var dhts = realm.all<RDht>();

    print(dhts.length);
    // Filter and sort object
    var objects = realm.query<RDht>("date>=1649195800 && date<=1649195900");
    objects.forEach(
      (ele) {
        print(
            'Nhiet do: ${ele.tempC} Do am: ${ele.humi} Count: ${ele.count} Date: ${ele.date}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DHT11',
                    ),
                    Padding(padding: EdgeInsets.all(4)),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Temperature',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Text(
                                    '${_sensorData.dht.tempC}??',
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Humidity',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Text(
                                    '${_sensorData.dht.humi}%',
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.all(8)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text('Count: ${_sensorData.dht.count}'),
            Text('Number save: ${realm.all<RDht>().length}'),
            ElevatedButton(
              onPressed: () => {sendGpioToServer(gpios[0])},
              child: Text('${gpios[0].name}'),
              style: ElevatedButton.styleFrom(
                  primary: gpios[0].value ? Colors.amber : Colors.black12),
            ),
          ],
        ),
      ),
    );
  }
}
