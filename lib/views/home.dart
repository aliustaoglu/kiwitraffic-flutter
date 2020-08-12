import 'package:flutter/material.dart';
import 'package:kiwitraffic/components/ActionButton.dart';
import 'package:kiwitraffic/views/header.dart';
import 'package:kiwitraffic/views/navBar.dart';

Scaffold scaffold = Scaffold(
  body: HomeBody(),
  backgroundColor: Color.fromARGB(255, 29, 32, 50),
  appBar: appBar,
  bottomNavigationBar: navBar,
);

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              ActionButton('assets/images/auckland.jpg', 'Auckland Traffic', (){
                Navigator.of(context).pushNamed('/auckland');
              }),
              ActionButton('assets/images/christchurch.jpg', 'Christchurch Roads', (){})
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              ActionButton('assets/images/camera.jpg', 'Cameras', (){

              }),
              ActionButton('assets/images/highway.jpg', 'Highway Status', (){})
            ],
          ),
        )
      ],
    );;
  }
}

