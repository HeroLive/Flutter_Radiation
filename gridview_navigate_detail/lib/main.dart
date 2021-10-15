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
      routes: {
        StationDetail.nameRoute: (context) => const StationDetail(),
      },
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  List<Station> stations = [
    Station(1, 'Tram 01', 'public', true, 20.1),
    Station(2, 'Tram 02', 'public', true, 20.2),
    Station(3, 'Tram 03', 'private', false, 20.3),
    Station(4, 'Tram 04', 'private', false, 20.4),
    Station(5, 'Tram 05', 'private', false, 20.5),
    Station(6, 'Tram 06', 'public', true, 20.6),
    Station(7, 'Tram 07', 'public', true, 20.7),
    Station(8, 'Tram 08', 'private', false, 20.8),
    Station(9, 'Tram 09', 'private', false, 20.9),
    Station(10, 'Tram 10', 'private', false, 30.0)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
        Navigator.pushNamed(context, StationDetail.nameRoute, arguments: item);
      },
      splashColor: Colors.red,
      child: Card(
        child: Container(
          color: item.status ? Colors.green : Colors.black12,
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

class StationDetail extends StatelessWidget {
  const StationDetail({Key? key}) : super(key: key);
  static const nameRoute = '/Detail';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Station;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: item.status ? Colors.green : Colors.black12,
        title: Text(item.name),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.temp}',
              style: TextStyle(color: Colors.red, fontSize: 60),
            ),
            Text(
              'O',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            Text(
              'C',
              style: TextStyle(color: Colors.red, fontSize: 60),
            ),
          ],
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
  double temp;
  Station(this.id, this.name, this.type, this.status, this.temp);
}
