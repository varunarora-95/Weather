import 'package:weather/domain/entity/weather_details.dart';

class WeatherForecast {
  WeatherForecast({
    required this.cnt,
    required this.weatherDetails,
    required this.city,
  });

  late final int cnt;
  late final List<WeatherDetails> weatherDetails;
  late final City city;

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    weatherDetails = List.from(json['list']).map((e) => WeatherDetails.fromJson(e)).toList();
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cnt'] = cnt;
    data['list'] = weatherDetails.map((e) => e.toJson()).toList();
    data['city'] = city.toJson();
    return data;
  }
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });
  late final int id;
  late final String name;
  late final Coord coord;
  late final String country;
  late final int population;
  late final int timezone;
  late final int sunrise;
  late final int sunset;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = Coord.fromJson(json['coord']);
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['coord'] = coord.toJson();
    _data['country'] = country;
    _data['population'] = population;
    _data['timezone'] = timezone;
    _data['sunrise'] = sunrise;
    _data['sunset'] = sunset;
    return _data;
  }
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });
  late final double lat;
  late final double lon;

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lon'] = lon;
    return _data;
  }
}
