class CityDetails {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;

  CityDetails({this.name, this.lat, this.lon, this.country, this.state});

  CityDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lon'] = lon;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}
