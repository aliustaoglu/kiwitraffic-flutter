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
    cam.imageUrl = camera.getElement('tns:imageUrl')?.text;
    cam.lat = double.parse(camera.getElement('tns:lat')?.text);
    cam.lng = double.parse(camera.getElement('tns:lon')?.text);
    cam.name = camera.getElement('tns:name')?.text;
    cam.offline = camera.getElement('tns:offline')?.text;
    cam.region = camera.getElement('tns:region')?.text;
    cam.thumbUrl = camera.getElement('tns:thumbUrl')?.text;
    cam.underMaintenance = camera.getElement('tns:underMaintenance')?.text;
    cam.viewUrl = camera.getElement('tns:viewUrl')?.text;
    return cam;
  });

  return listOfCams.toList();
}