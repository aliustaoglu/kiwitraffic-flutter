class ChristchurchEventModel {
  double lat;
  double lng;
  String eventType;
  String eventDescription;
  String startDate;
  String endDate;
  String impact;
  String companyName;
  String restrictions;
  String lastUpdate;
  String expectedResolution;
  String locationArea;
}

class ChristchurchRoadModel {
  List<ChristchurchEventModel> events;

  ChristchurchRoadModel(this.events);

  factory ChristchurchRoadModel.fromJSON(Map<String, dynamic> json){
    List<ChristchurchEventModel> listEvents = new List<ChristchurchEventModel>();
    for (var feature in json['features']){
      ChristchurchEventModel event = new ChristchurchEventModel();
      event.lat = feature['geometry']['coordinates'][1];
      event.lng = feature['geometry']['coordinates'][0];

      event.eventType = feature['properties']['EventType'] ?? '';
      event.startDate = feature['properties']['StartDateNice'] ?? '';
      event.expectedResolution = feature['properties']['ExpectedResolution'] ?? '';
      event.eventDescription = feature['properties']['EventDescription'] ?? '';
      event.impact = feature['properties']['impact'] ?? '';
      event.endDate = feature['properties']['EndDateNice'] ?? '';
      event.companyName = feature['properties']['CompanyName'] ?? '';
      event.restrictions = feature['properties']['Restrictions'] ?? '';
      event.lastUpdate = feature['properties']['LastUpdatedNice'] ?? '';
      event.locationArea = feature['properties']['LocationArea'] ?? '';
      listEvents.add(event);
    }

    return ChristchurchRoadModel(listEvents);
  }
}