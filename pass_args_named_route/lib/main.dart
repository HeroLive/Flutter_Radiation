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
        DetailScreen.nameRoute: (context) => const DetailScreen(),
      },
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DetailScreen.nameRoute,
                      arguments: ArgumentScreen("Title 1", "Content 1"));
                },
                child: const Text('Item 1')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DetailScreen.nameRoute,
                      arguments: ArgumentScreen("Title 2", "Content 2"));
                },
                child: const Text('Item 2'))
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);
  static const nameRoute = '/Detail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArgumentScreen;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.content),
      ),
    );
  }
}

class ArgumentScreen {
  String title;
  String content;
  ArgumentScreen(this.title, this.content);
}
