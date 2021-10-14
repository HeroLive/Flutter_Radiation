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
      title: 'Flutter Demo',
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
    Station(10, 'Tram 10', 'private', false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: GridView.count(
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        children: stations.map((item) {
          return StationItem(item: item);
        }).toList(),
      ),
    );
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
          color: item.status ? Colors.green : Colors.black12,
          alignment: Alignment.center,
          child: Text(
            item.name,
            style: TextStyle(
                color: Colors.orange,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
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
