import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/CameraModel.dart';
import 'package:kiwitraffic/views/cameraModal.dart';
import 'package:kiwitraffic/views/home.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:kiwitraffic/utils/aucklandUtil.dart' as aucklandUtil;
import 'package:kiwitraffic/utils/polylineUtil.dart';
import 'package:http/http.dart' as http;
import 'package:kiwitraffic/utils/endpoints.dart' as endpoints;
import 'package:kiwitraffic/models/TrafficModel.dart';

class Auckland extends StatefulWidget {
  @override
  _AucklandState createState() => _AucklandState();
}

class _AucklandState extends State<Auckland> {
  BitmapDescriptor pinLocationIcon;

  var markers = Set<Marker>();
  var polylines = Set<Polyline>();
  var polylinesFree = Set<Polyline>();
  var polylinesModerate = Set<Polyline>();
  var polylinesHeavy = Set<Polyline>();

  setMarker() async {
    List<CameraModel> cameras = await aucklandUtil.getCameras();
    var icn = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.1),
        'assets/icons/traffic-cams.png');

    List<Marker> lst = [];
    cameras.forEach((camera) {
      var marker = Marker(
        markerId: MarkerId(camera.id),
        position: LatLng(camera.lat, camera.lng),
        icon: icn,
        consumeTapEvents: true,
        onTap: () {
          Navigator.pushNamed(context, 'auckland/camera', arguments: camera);
        },
      );
      lst.add(marker);
    });
    setState(() {
      markers = Set<Marker>.of(lst);
    });
  }

  setPolylines() async {
    List<TrafficModel> listTraffic = await aucklandUtil.getTraffic();

    Set<Polyline> setPolylinesFree = new Set<Polyline>();
    Set<Polyline> setPolylinesModerate = new Set<Polyline>();
    Set<Polyline> setPolylinesHeavy = new Set<Polyline>();
    aucklandPolylines.forEach((key, latLngPoints){
      List<LatLng> latLngList = new List<LatLng>();
      for (var latLngPoint in latLngPoints) {
        latLngList.add(new LatLng(latLngPoint.latitude, latLngPoint.longitude));
      }
      var trafficResult = listTraffic.firstWhere((element)=>element.name == key,  orElse: () => null);
      if (trafficResult != null) {
        if (trafficResult.congestion == 'Free Flow') {
          setPolylinesFree.add(new Polyline(polylineId: PolylineId(key),
              points: latLngList,
              color: Colors.green,
              visible: true,
              width: 2));
        }
        if (trafficResult.congestion == 'Moderate') {
          setPolylinesModerate.add(new Polyline(polylineId: PolylineId(key),
              points: latLngList,
              color: Colors.amber,
              visible: true,
              width: 2));
        }
        if (trafficResult.congestion == 'Heavy') {
          setPolylinesHeavy.add(new Polyline(polylineId: PolylineId(key),
              points: latLngList,
              color: Colors.red,
              visible: true,
              width: 2));
        }
      }

    });
    setState(() {
      var sets = [...setPolylinesFree, ...setPolylinesModerate, ...setPolylinesHeavy];
      polylines = Set<Polyline>.of(sets);
    });
  }

  @override
  void initState() {
    setMarker();
    setPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Auckland Traffic'),
      ),
      body: PlatformMap(
        trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: const LatLng(-36, 174),
          zoom: 16.0,
        ),
        markers: markers,
        polylines: polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
//        onTap: (location) => print('onTap: $location'),
        compassEnabled: true,
        onMapCreated: (controller) {
          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(-36.8483, 174.7625),
                  zoom: 11
              ),
            ),
          );
        },
      ),
    );
  }
}
