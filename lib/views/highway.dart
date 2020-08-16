import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:kiwitraffic/utils/highwayUtil.dart' as highwayUtil;

class Highway extends StatefulWidget {
  @override
  _HighwayState createState() => _HighwayState();
}

Future<BitmapDescriptor> getIcon(String eventType) async{
  String iconName = '';
  if (eventType == 'Area Warning') iconName = 'assets/icons/areawarnings.png';
  if (eventType == 'Road Closure') iconName = 'assets/icons/roadclosures.png';
  if (eventType == 'Road Hazard') iconName = 'assets/icons/roadhazards.png';
  if (eventType == 'Road Work') iconName = 'assets/icons/roadworks.png';

  var icn = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.1),
      iconName);
  return icn;
}

class _HighwayState extends State<Highway> {
  var markers = Set<Marker>();

  setHighwayStatus() async {
    var resHighwayStatus = await highwayUtil.getHighwayStatus();
    var highwayMarkers = Set<Marker>();

    for (var event in resHighwayStatus.events) {
      var icon = await getIcon(event.eventType);
      Marker marker = new Marker(
          markerId: MarkerId("loc${event.lat}${event.lng}"),
          position: LatLng(event.lat, event.lng),
          icon: icon,
        onTap: (){
            Navigator.of(context).pushNamed('/highway/status', arguments: event);
        }
      );
      highwayMarkers.add(marker);
    }

    setState(() {
      markers = highwayMarkers;
    });
  }

  @override
  void initState() {
    setHighwayStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Highway Status'),
      ),
      body: PlatformMap(
        trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: const LatLng(-40.9006, 174.8860),
          zoom: 5.0,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
      ),
    );
  }
}
