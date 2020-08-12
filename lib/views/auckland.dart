import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/CameraModel.dart';
import 'package:kiwitraffic/views/cameraModal.dart';
import 'package:kiwitraffic/views/home.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:kiwitraffic/utils/aucklandUtil.dart' as aucklandUtil;

class Auckland extends StatefulWidget {
  @override
  _AucklandState createState() => _AucklandState();
}

class _AucklandState extends State<Auckland> {
  BitmapDescriptor pinLocationIcon;

  var markers = Set<Marker>.of([]);

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
        title: Text('Auckland Traffic'),
      ),
      body: PlatformMap(
        trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: const LatLng(-36, 174),
          zoom: 16.0,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
//        onTap: (location) => print('onTap: $location'),
        compassEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(Duration(seconds: 2)).then(
            (_) {
              controller.moveCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    target: LatLng(-36.8483, 174.7625),
                    zoom: 10
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
