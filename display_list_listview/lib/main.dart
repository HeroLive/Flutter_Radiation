import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Display list by ListView',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  List<Station> stations = [
    Station(1, 'Tram 01', 'public', true),
    Station(2, 'Tram 02', 'public', true),
    Station(3, 'Tram 03', 'private', false),
    Station(4, 'Tram 05', 'private', false),
    Station(5, 'Tram 05', 'private', false),
    Station(6, 'Tram 06', 'public', true),
    Station(7, 'Tram 07', 'public', true),
    Station(8, 'Tram 08', 'private', false),
    Station(9, 'Tram 09', 'private', false),
    Station(10, 'Tram 10', 'private', false),
    Station(1, 'Tram 11', 'public', true),
    Station(2, 'Tram 02', 'public', true),
    Station(3, 'Tram 03', 'private', false),
    Station(4, 'Tram 05', 'private', false),
    Station(5, 'Tram 05', 'private', false),
    Station(6, 'Tram 06', 'public', true),
    Station(7, 'Tram 07', 'public', true),
    Station(8, 'Tram 08', 'private', false),
    Station(9, 'Tram 09', 'private', false),
    Station(10, 'Tram 20', 'private', false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final item = stations[index];
            return ListTile(
              leading: Icon(Icons.online_prediction,
                  color: item.status ? Colors.blue : Colors.grey),
              title: Text(
                item.name,
                style: TextStyle(color: Colors.orange),
              ),
              trailing: Icon(item.type == 'public' ? Icons.public : Icons.lock),
            );
          }),
    );
  }
}

class Station {
  int id;
  String name;
  String type;
  bool status;
  Station(this.id, this.name, this.type, this.status);
}
