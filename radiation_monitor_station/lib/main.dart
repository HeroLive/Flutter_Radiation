import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'station.dart';

void main() {
  runApp(const MyApp());
}

IO.Socket socket = IO.io('https://rewes1.glitch.me',
    IO.OptionBuilder().setTransports(['websocket']).build());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radiation monitor',
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
      home: const MyHomePage(title: 'Home Page'),
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
  List<Station> stations = [];
  void initState() {
    super.initState();
    connectAndListen();
  }

  void connectAndListen() {
    print('Call func connectAndListen');
    socket.onConnect((_) {
      print('connect');
    });

    socket.on('stations', (data) {
      print('from server $data');
      // '{"name":"Tram2","geolocation":{"latitude":10,"longitude":106},"address":"227-NguyenVanCu","id":"8UKlMQhi9uXujou9AAAs"}';
      List<dynamic> _stations = data;
      setState(() {
        stations =
            _stations.map<Station>((json) => Station.fromJson(json)).toList();
      });
      print(stations);
    });

    //When an event recieved from server, data is added to the stream
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              return StationItem(item: stations[index]);
            }));
  }
}

class StationItem extends StatelessWidget {
  const StationItem({Key? key, required this.item}) : super(key: key);
  final Station item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Clicked ${item.name}');
      },
      splashColor: Colors.red,
      child: Card(
        child: Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: Text(
            item.name,
            style: const TextStyle(
                color: Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
