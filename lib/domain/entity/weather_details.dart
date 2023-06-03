import 'package:weather/domain/entity/coordinates.dart';

class WeatherDetails {
  late final Coordinates? coordinates;
  late final Temperature temperature;
  late final List<Weather> weather;
  late final Wind wind;
  late final num visibility;
  late final num? timezone;
  late final String? name;
  late final String? dtTxt;

  DateTime? get dateTime => dtTxt != null ? DateTime.parse(dtTxt!) : null;

  WeatherDetails.fromJson(Map<String, dynamic> json) {
    coordinates = json['coord'] != null ? Coordinates.fromJson(json['coord']) : null;
    temperature = Temperature.fromJson(json['main']);
    weather = List.from(json['weather']).map((e) => Weather.fromJson(e)).toList();
    wind = Wind.fromJson(json['wind']);
    visibility = json['visibility'];
    timezone = json['timezone'];
    name = json['name'];
    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['coords'] = coordinates;
    data['main'] = temperature.toJson();
    data['weather'] = weather.map((e) => e.toJson()).toList();
    data['wind'] = wind.toJson();
    data['visibility'] = visibility;
    data['timezone'] = timezone;
    data['name'] = name;
    data['dt_txt'] = dtTxt;
    return data;
  }
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Temperature {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? humidity;

  Temperature({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
  });

  Temperature.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['humidity'] = humidity;
    return data;
  }
}

class Wind {
  num? speed;

  Wind({this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    return data;
  }
}
