const aucklandTrafficConditions = 'https://infoconnect1.highwayinfo.govt.nz/ic/jbi/TrafficConditions2/REST/FeedService/?wsdl';
const aucklandSigns = 'https://infoconnect1.highwayinfo.govt.nz/ic/jbi/VariableMessageSigns2/REST/FeedService/?wsdl';
const aucklandCameras = 'https://infoconnect1.highwayinfo.govt.nz/ic/jbi/TrafficCameras2/REST/FeedService/?wsdl';

String infoConnectUser = String.fromEnvironment('infoConnectUser');
String infoConnectPass = String.fromEnvironment('infoConnectPass');

const treisFeed = 'https://infoconnect1.highwayinfo.govt.nz/ic/jbi/TREIS/REST/FeedService/';

const markerCollection = 'https://www.journeys.nzta.govt.nz/assets/tas/markercollection.json';
const journeyCollection = 'https://www.journeys.nzta.govt.nz/assets/tas/journeycollection.json';
const regionCollection = 'https://www.journeys.nzta.govt.nz/assets/tas/regions.json';
const cameraCollection = 'https://www.journeys.nzta.govt.nz/assets/tas/cameras.json';

const canterburyRoadworks = 'https://journeys.nzta.govt.nz/assets/roadworks/canterbury-roadworks-markers.json';
const canterburyClosure = 'https://journeys.nzta.govt.nz/assets/roadworks/canterbury-closure-markers.json';
const canterburyXRoadworks = 'https://journeys.nzta.govt.nz/assets/roadworks/canterbury-roadworks-extents.json';
const canterburyXClosure = 'https://journeys.nzta.govt.nz/assets/roadworks/canterbury-closure-extents.json';