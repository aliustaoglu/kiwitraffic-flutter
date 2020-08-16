import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/HighwayModel.dart';

TextStyle txtTitle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    decoration: TextDecoration.underline
);

TextStyle txtInfo = TextStyle(
  color: Colors.white,
    fontSize: 18
);

class HighwayStatus extends StatefulWidget {
  @override
  _HighwayStatusState createState() => _HighwayStatusState();
}

class _HighwayStatusState extends State<HighwayStatus> {
  @override
  Widget build(BuildContext context) {
    HighwayEvent highwayEvent = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 32, 50),
      appBar: AppBar(
        title: Text('${highwayEvent.eventType}: ${highwayEvent.eventDescription}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(highwayEvent.locationArea, style: txtInfo,),
            SizedBox(height: 20,),
            Text(highwayEvent.eventDescription, style: txtInfo,),
            SizedBox(height: 20,),
            Text(highwayEvent.eventComments, style: txtInfo,),
            SizedBox(height: 20,),
            Text('Scheduled Time', style: txtTitle,),
            Text(highwayEvent.startDate, style: txtInfo,),
            SizedBox(height: 20,),
            Text('Detour Route', style: txtTitle,),
            Text(highwayEvent.alternativeRoute, style: txtInfo,),
            SizedBox(height: 20,),
            Text('Update Received', style: txtTitle,),
            Text(highwayEvent.eventModified, style: txtInfo,),
            SizedBox(height: 20,),
            Text('Expected Resolution', style: txtTitle,),
            Text(highwayEvent.expectedResolution, style: txtInfo,),
          ],
        ),
      ),
    );
  }
}
