import 'package:http/http.dart' as http;
import 'package:kiwitraffic/utils/endpoints.dart' as endpoints;
import 'package:kiwitraffic/models/ChristchurchModel.dart';
import 'dart:convert';

Future<ChristchurchRoadModel> getChristchurchEvents() async{
  final evts = await http.get(endpoints.canterburyRoadworks);
  ChristchurchRoadModel christchurchRoadModel = ChristchurchRoadModel.fromJSON(json.decode(evts.body));
  return christchurchRoadModel;

}