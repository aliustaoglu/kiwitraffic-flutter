import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/CameraModel.dart';
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
    var icn = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 1.1), 'assets/icons/traffic-cams.png');
    setState(() {
      List<Marker> lst = [];
      cameras.forEach((camera){
        var marker = Marker(
          markerId: MarkerId(camera.id),
          position: LatLng(-36, 174),
          icon: icn,
          consumeTapEvents: true,
          infoWindow: InfoWindow(
              title: 'PlatformMarker',
              snippet: "Hi I'm a Platform Marker",
              onTap: () {
                print("InfoWindow tapped");
              }),
          onTap: () {
            print("Marker tapped");
          },
        );
        lst.add(marker);
      });

      markers = Set<Marker>.of(lst);
    });

  }

  @override
  void initState() {
    super.initState();
    setMarker();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auckland Traffic'),
      ),
      body: PlatformMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(-36, 174),
          zoom: 16.0,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (location) => print('onTap: $location'),
        compassEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(Duration(seconds: 2)).then(
            (_) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(

                    target: LatLng(-36, 174),

                    zoom: 8,
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
