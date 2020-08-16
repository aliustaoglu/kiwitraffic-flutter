import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:kiwitraffic/models/CameraModel.dart';
import 'package:kiwitraffic/utils/aucklandUtil.dart' as aucklandUtil;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  var markers = Set<Marker>();

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

  @override
  void initState() {
    setMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic Cameras'),
      ),
      body: PlatformMap(
        trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: const LatLng(-40.9006, 174.8860),
          zoom: 6.0,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
