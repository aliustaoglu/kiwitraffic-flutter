import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/CameraModel.dart';

TextStyle headerStyle = TextStyle(
    backgroundColor: Color.fromARGB(255, 41, 47, 71), color: Colors.white);

TextStyle titleStyle = TextStyle(
  color: Colors.amberAccent,
  fontSize: 18,
  fontWeight: FontWeight.w600
);

TextStyle colorStyle = TextStyle(
  color: Colors.white
);

class CameraModal extends StatefulWidget {

  @override
  _CameraModalState createState() => _CameraModalState();
}

class _CameraModalState extends State<CameraModal> {

  @override
  Widget build(BuildContext context) {

    CameraModel camera = ModalRoute.of(context).settings.arguments;
    List<Widget> congestions = new List<Widget>();
    for (var congestion in camera.congestions){
      congestions.add(
          Text('${congestion.name}: ${congestion.congestion}', style: colorStyle,)
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(camera.name),
        actions: [],
      ),
      body: Container(
        color: Color.fromARGB(255, 29, 32, 50),
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.white,),
                title: Text(camera.description, style: colorStyle)
              ),
              Image(
                image: NetworkImage(camera.imageUrl),
              ),
              SizedBox(height: 10,),
              Column(
                children: congestions,
              )
            ],
          ),
        ),
      ),
    );
  }
}
