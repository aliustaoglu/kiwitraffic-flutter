import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/CameraModel.dart';

TextStyle headerStyle = TextStyle(
    backgroundColor: Color.fromARGB(255, 41, 47, 71), color: Colors.white);

class CameraBottomSheet extends StatefulWidget {
  CameraModel camera;

  CameraBottomSheet(this.camera);

  @override
  _CameraBottomSheetState createState() => _CameraBottomSheetState(this.camera);
}

class _CameraBottomSheetState extends State<CameraBottomSheet> {
  CameraModel camera;

  _CameraBottomSheetState(this.camera);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 41, 47, 71),
      child: Column(
        children: [
          Padding(
              child: Text(
                camera.name,
                style: TextStyle(color: Colors.white),
              ),
              padding: EdgeInsets.all(
                8,
              )),
          Image(
            image: NetworkImage(camera.imageUrl),
          )
        ],
      ),
    );
  }
}
