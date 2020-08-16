import 'package:flutter/material.dart';
import 'package:kiwitraffic/models/ChristchurchModel.dart';

TextStyle txtTitle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    decoration: TextDecoration.underline
);

TextStyle txtInfo = TextStyle(
    color: Colors.white,
    fontSize: 18
);

class ChristchurchModal extends StatefulWidget {
  @override
  _ChristchurchModalState createState() => _ChristchurchModalState();
}

class _ChristchurchModalState extends State<ChristchurchModal> {
  @override
  Widget build(BuildContext context) {
    ChristchurchEventModel event = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 32, 50),
      appBar: AppBar(
        title: Text(event.eventType),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.locationArea, style: txtInfo,),
            SizedBox(height: 10,),
            Text(event.eventDescription, style: txtInfo,),
            SizedBox(height: 10,),
            Text('Impact', style: txtTitle),
            SizedBox(height: 5,),
            Text(event.impact, style: txtInfo,),
            SizedBox(height: 10,),
            Text('Restrictions', style: txtTitle),
            SizedBox(height: 5,),
            Text(event.restrictions, style: txtInfo,),
            SizedBox(height: 10,),
            Text('Start Date', style: txtTitle),
            SizedBox(height: 5,),
            Text(event.startDate, style: txtInfo,),
            SizedBox(height: 10,),
            Text('End Date', style: txtTitle),
            SizedBox(height: 5,),
            Text(event.endDate, style: txtInfo,),
            SizedBox(height: 10,),
            Text('Last Updated', style: txtTitle),
            SizedBox(height: 5,),
            Text(event.lastUpdate, style: txtInfo,),
            SizedBox(height: 10,),
            Text('Company', style: txtTitle),
            SizedBox(height: 5,),
            Text(event.companyName, style: txtInfo,),

          ],
        ),
      ),
    );
  }
}
