import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Graphql Blog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const <Widget>[
                  FittedBox(
                    child: FlutterLogo(
                      size: 65,
                    ),
                    // Image.network('https://picsum.photos/250?image=9')
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Technical SEO with Hygraph",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Get started with your SEO ...",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
