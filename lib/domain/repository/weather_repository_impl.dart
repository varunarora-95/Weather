import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/constants.dart';
import 'package:weather/domain/entity/city_details.dart';
import 'package:weather/domain/entity/weather_details.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final String baseURL = 'http://api.openweathermap.org';
  final String geoAPI = 'geo/1.0';
  final String weatherAPI = 'data/2.5';

  @override
  Future<CityDetails> getCity(String query) async {
    final apiUrl = '$baseURL/$geoAPI/direct?q=$query&limit=5&appid=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CityDetails.fromJson(data);
    } else {
      throw Exception('Unable to find any city for $query');
    }
  }

  @override
  Future<WeatherDetails> getCurrentWeather(double lat, double lon) async {
    final apiUrl = '$baseURL/$weatherAPI/weather?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherDetails.fromJson(data);
    } else {
      throw Exception('Failed to get weather for $lat,$lon');
    }
  }

  @override
  Future<WeatherForecast> getForecast(double lat, double lon) async {
    final apiUrl = '$baseURL/$weatherAPI/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherForecast.fromJson(data);
    } else {
      throw Exception('Failed to get forecast for $lat,$lon');
    }
  }
}
