import 'package:weather/domain/entity/city_details.dart';
import 'package:weather/domain/entity/weather_details.dart';
import 'package:weather/domain/entity/weather_forecast.dart';

abstract class WeatherRepository {
  Future<CityDetails> getCity(String query);
  Future<WeatherDetails> getCurrentWeather(double lat, double lon);
  Future<WeatherForecast> getForecast(double lat, double lon);
}
