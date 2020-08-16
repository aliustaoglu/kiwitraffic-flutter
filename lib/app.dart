import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwitraffic/theme.dart';
import 'package:kiwitraffic/views/auckland.dart';
import 'package:kiwitraffic/views/home.dart';
import 'package:kiwitraffic/views/cameraModal.dart';
import 'package:kiwitraffic/views/camera.dart';
import 'package:kiwitraffic/views/highway.dart';
import 'package:kiwitraffic/views/highwayModal.dart';
import 'package:kiwitraffic/views/christchurch.dart';
import 'package:kiwitraffic/views/christchurchModal.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: HomeScaffold(),
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeScaffold(),
          '/auckland': (context) => Auckland(),
          'auckland/camera': (context) => CameraModal(),
          '/camera': (context) => Camera(),
          '/highway': (context) => Highway(),
          '/highway/status': (context) => HighwayStatus(),
          '/christchurch': (context) => Christchurch(),
          '/christchurch/roadworks': (context) => ChristchurchModal(),
        }
    );
  }
}
