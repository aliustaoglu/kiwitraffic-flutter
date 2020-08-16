import 'package:flutter/material.dart';
import 'package:kiwitraffic/components/ActionButton.dart';
import 'package:kiwitraffic/views/header.dart';
import 'package:kiwitraffic/views/navBar.dart';
import 'package:kiwitraffic/views/about.dart';

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentTab == 0 ? HomeBody() : About(),
      backgroundColor: Color.fromARGB(255, 29, 32, 50),
      appBar: appBar,
      bottomNavigationBar: navBar((selectedTab){
        setState(() {
          currentTab = selectedTab;
        });
      }),
    );
  }
}


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
              ActionButton('assets/images/christchurch.jpg', 'Christchurch Roads', (){
                Navigator.of(context).pushNamed('/christchurch');
              })
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              ActionButton('assets/images/camera.jpg', 'Cameras', (){
                Navigator.of(context).pushNamed('/camera');
              }),
              ActionButton('assets/images/highway.jpg', 'Highway Status', (){
                Navigator.of(context).pushNamed('/highway');
              })
            ],
          ),
        )
      ],
    );;
  }
}
