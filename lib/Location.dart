class Location {
  String name;
  int id;
  double lat;
  double long;
  String covidData;
  Location(int id1, String name1, double lat1, double long1, String data) {
    name = name1;
    id = id1;
    lat = lat1;
    long = long1;
    covidData = data;
  }
}