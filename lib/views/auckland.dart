import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class Auckland extends StatefulWidget {
  @override
  _AucklandState createState() => _AucklandState();
}

class _AucklandState extends State<Auckland> {
  BitmapDescriptor pinLocationIcon;
  var markers = Set<Marker>.of([]);

  setMarker() async {
    var icn = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/logo.png');
    setState(() {
      var marker = Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(47.6, 8.8796),
        icon: pinLocationIcon,
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
      markers = Set<Marker>.of([
        marker
      ]);
    });

  }

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(47.6, 8.8796),
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
                    bearing: 270.0,
                    target: LatLng(51.5160895, -0.1294527),
                    tilt: 30.0,
                    zoom: 18,
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
