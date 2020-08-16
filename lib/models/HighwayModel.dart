class AreaWarnings {}

class GeneralWarnings {}

class RoadClosures {}

class RoadHazards {}

class Roadworks {
  String alternativeRoute;
  String endDate;
  String eventComments;
  String eventDescription;
  String eventModified;
  String eventType;
  String impact;
  String locationArea;
  String startDate;
  double lat;
  double lng;
}

class TimSigns {}

class VmsSigns {}

class HighwayEvent {
  String alternativeRoute;
  String endDate;
  String eventComments;
  String eventDescription;
  String eventModified;
  String eventType;
  String impact;
  String locationArea;
  String expectedResolution;
  String startDate;
  double lat;
  double lng;
}

class HighwayModel {
  List<HighwayEvent> events;

  HighwayModel({this.events});

  factory HighwayModel.fromJSON(Map<String, dynamic> json) {
    List<HighwayEvent> listHighwayEvents = new List<HighwayEvent>();

    List<dynamic> roadWorks = json['roadworks']['features'];
    List<dynamic> roadHazards = json['roadhazards']['features'];
    List<dynamic> roadClosures = json['roadclosures']['features'];
    List<dynamic> areaWarnings = json['areawarnings']['features'];
    var allEvents = [
      ...roadWorks,
      ...roadHazards,
      ...roadClosures,
      ...areaWarnings
    ];
    for (var event in allEvents) {
      if (event['geometry']['type'] == 'Point') {
        HighwayEvent highwayEvent = new HighwayEvent();
        highwayEvent.lat = event['geometry']['coordinates'][1];
        highwayEvent.lng = event['geometry']['coordinates'][0];
        highwayEvent.alternativeRoute = event['properties']['alternativeRoute'];
        highwayEvent.endDate = event['properties']['endDateNice'];
        highwayEvent.eventComments = event['properties']['eventComments'];
        highwayEvent.eventDescription = event['properties']['eventDescription'];
        highwayEvent.eventModified = event['properties']['eventModifiedNice'];
        highwayEvent.eventType = event['properties']['eventType'];
        highwayEvent.locationArea = event['properties']['locationArea'];
        highwayEvent.startDate = event['properties']['startDateNice'];
        highwayEvent.impact= event['properties']['impact'];
        highwayEvent.expectedResolution = event['properties']['expectedResolution'];
        listHighwayEvents.add(highwayEvent);
      }
    }

    return HighwayModel(events: listHighwayEvents);
  }
}
