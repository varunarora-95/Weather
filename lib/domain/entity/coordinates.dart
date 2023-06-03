class Coordinates {
  Coordinates({
    required this.lat,
    required this.lon,
  });
  late final double lat;
  late final double lon;

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
