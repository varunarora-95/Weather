import 'package:weather/domain/entity/coordinates.dart';
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
  late final Coordinates coord;
  late final String country;
  late final int population;
  late final int timezone;
  late final int sunrise;
  late final int sunset;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = Coordinates.fromJson(json['coord']);
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['coord'] = coord.toJson();
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
