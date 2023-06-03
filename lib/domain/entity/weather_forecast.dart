import 'package:weather/domain/entity/weather_details.dart';

class WeatherForecast {
  WeatherForecast({required this.weatherDetails});

  late final List<WeatherDetails> weatherDetails;

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    weatherDetails = List.from(json['list']).map((e) => WeatherDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = weatherDetails.map((e) => e.toJson()).toList();
    return data;
  }
}
