import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:kiwitraffic/utils/christchurchUtil.dart' as util;

class Christchurch extends StatefulWidget {
  @override
  _ChristchurchState createState() => _ChristchurchState();
}

class _ChristchurchState extends State<Christchurch > {
  var markers = Set<Marker>();

  getChristchurchRoads() async{
    var icn = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.1),
        'assets/icons/roadworks.png');

    final roadworks = await util.getChristchurchEvents();
    var markerIcons = Set<Marker>();
    for (var event in roadworks.events) {
      Marker marker = new Marker(
        markerId: MarkerId('evt${event.lat}${event.lng}'),
        position: LatLng(event.lat, event.lng),
        icon: icn,
        onTap: () {
          Navigator.of(context).pushNamed('/christchurch/roadworks', arguments: event);
        }
      );
      markerIcons.add(marker);
    }
    setState(() {
      markers = markerIcons;
    });

  }

  @override
  void initState() {
    getChristchurchRoads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Christchurch Roads'),
        ),
      body: PlatformMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(-43.5320, 172.6397),
          zoom: 11.0,
        ),
        markers: markers,
      )
    );
  }
}
