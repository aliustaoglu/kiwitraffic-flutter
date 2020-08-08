import 'package:flutter/material.dart';
import 'package:kiwitraffic/components/ActionButton.dart';
import 'package:kiwitraffic/views/header.dart';
import 'package:kiwitraffic/views/navBar.dart';

Scaffold scaffold = Scaffold(
  body: body,
  backgroundColor: Color.fromARGB(255, 29, 32, 50),
  appBar: appBar,
  bottomNavigationBar: navBar,
);

Widget body = Column(
  children: [
    Expanded(
      child: Row(
        children: [
          ActionButton('assets/images/auckland.jpg'),
          ActionButton('assets/images/christchurch.jpg')
        ],
      ),
    ),
    Expanded(
      child: Row(
        children: [
          ActionButton('assets/images/camera.jpg'),
          ActionButton('assets/images/highway.jpg')
        ],
      ),
    )
  ],
);