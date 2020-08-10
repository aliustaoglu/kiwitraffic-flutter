import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kiwitraffic/models/CameraModel.dart';
import 'package:kiwitraffic/utils/endpoints.dart' as endpoints;
import 'package:xml/xml.dart';

Future<List<CameraModel>> getCameras() async {
  var resCamera = await http.get(endpoints.aucklandCameras, headers: {
    'username': 'user',
    'password': 'pass'
  });
  final document = XmlDocument.parse(resCamera.body);

  List<XmlNode> cameras = document.children[1].children;

  List<CameraModel> nztaCameras = new List<CameraModel>();

  //XmlElement camera1 = cameras[0];

  var listOfCams = cameras.map((camera){
    CameraModel cam = new CameraModel();
    cam.description = camera.getElement('tns:description')?.text;
    cam.direction = camera.getElement('tns:direction')?.text;
    cam.group = camera.getElement('tns:group')?.text;
    cam.id = camera.getElement('tns:id')?.text;
    cam.imageUrl = camera.getElement('tns:id')?.text;
    cam.lat = camera.getElement('tns:id')?.text;
    cam.lng = camera.getElement('tns:id')?.text;
    cam.name = camera.getElement('tns:id')?.text;
    cam.offline = camera.getElement('tns:id')?.text;
    cam.region = camera.getElement('tns:id')?.text;
    cam.thumbUrl = camera.getElement('tns:id')?.text;
    cam.underMaintenance = camera.getElement('tns:id')?.text;
    cam.viewUrl = camera.getElement('tns:id')?.text;
    return cam;
  });

  return listOfCams.toList();
}