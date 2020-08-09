import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwitraffic/theme.dart';
import 'package:kiwitraffic/views/auckland.dart';
import 'package:kiwitraffic/views/header.dart';
import 'package:kiwitraffic/views/home.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: scaffold,
        initialRoute: '/home',
        routes: {
          '/home': (context) => scaffold,
          '/auckland': (context) => Auckland()
        }
    );
  }
}
