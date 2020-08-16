import 'package:http/http.dart' as http;
import 'package:kiwitraffic/utils/endpoints.dart' as endpoints;
import 'package:kiwitraffic/utils/headers.dart';
import 'package:kiwitraffic/utils/highwayUtil.dart' as highwayUtil;
import 'package:kiwitraffic/models/HighwayModel.dart';
import 'dart:convert';

Future<HighwayModel> getHighwayStatus() async {
  final markerCollection = await http.get(endpoints.markerCollection);
  HighwayModel highwayModel = HighwayModel.fromJSON(json.decode(markerCollection.body));
  return highwayModel;
}
