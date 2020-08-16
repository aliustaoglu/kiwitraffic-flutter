import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kiwitraffic/models/CameraModel.dart';
import 'package:kiwitraffic/models/TrafficModel.dart';
import 'package:kiwitraffic/utils/endpoints.dart' as endpoints;
import 'package:xml/xml.dart';
import 'package:kiwitraffic/utils/headers.dart';


Future<List<CameraModel>> getCameras() async {
  var resCamera = await http.get(endpoints.aucklandCameras, headers: headers);
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
    cam.congestions = new List<Congestion>();

    var congestionLocations = camera.findAllElements('tns:congestionLocations');
    if (congestionLocations.length > 0) {
      for (var congestionLocation in congestionLocations){
        Congestion congestion = new Congestion();
        congestion.congestion = congestionLocation.getElement('tns:congestion').text;
        congestion.direction= congestionLocation.getElement('tns:direction').text;
        congestion.name= congestionLocation.getElement('tns:name').text;
        cam.congestions.add(congestion);
      }


    }

    return cam;
  });

  return listOfCams.toList();
}

Future<List<TrafficModel>> getTraffic() async {
  final resTraffic = await http.get(endpoints.aucklandTrafficConditions, headers: headers);
  final document = XmlDocument.parse(resTraffic.body);
  List<TrafficModel> listTraffic = new List<TrafficModel>();
  List<XmlNode> motorways = document.getElement('tns:getTrafficConditionsResponse').getElement('tns:trafficConditions').children;
  for (XmlElement motorway in motorways) {
    if (motorway.name.toString() == 'tns:motorways') {
      for (XmlElement location in motorway.children) {
        if (location.name.toString() == 'tns:locations') {
          TrafficModel t = new TrafficModel();
          t.congestion = location.getElement('tns:congestion').text;
          t.name= location.getElement('tns:name').text;
          t.direction = location.getElement('tns:direction').text;
          t.inOut = location.getElement('tns:inOut').text;
          listTraffic.add(t);
        }
      }
    }
  }
  return listTraffic;
  
}

Future<List<TrafficSigns>> getTrafficSigns() async {
  var trafficSigns = new List<TrafficSigns>();
  final resSigns = await http.get(endpoints.aucklandSigns, headers: headers);
  final document = XmlDocument.parse(resSigns.body);
  for (XmlElement sign in document.getElement("tns:getSignsResponse").children) {
    if (sign.getElement('tns:current-message').text != '') {
      TrafficSigns trafficSign = new TrafficSigns();
      trafficSign.identifier = sign.getElement('tns:identifier').text;
      trafficSign.name = sign.getElement('tns:name').text;
      trafficSign.description = sign.getElement('tns:description').text;
      trafficSign.currentMessage = sign.getElement('tns:current-message').text.replaceAll('[nl]', ' ').replaceAll('[np]', ' ');
      trafficSign.lastUpdate = sign.getElement('tns:last-update').text;
      trafficSign.lat = double.tryParse(sign.getElement('tns:lat').text) ?? 0;
      trafficSign.lng = double.tryParse(sign.getElement('tns:lon').text) ?? 0;
      trafficSigns.add(trafficSign);
    }
  }
  return trafficSigns;
}