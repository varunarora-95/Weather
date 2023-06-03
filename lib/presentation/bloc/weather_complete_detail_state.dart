part of 'weather_detail_bloc.dart';

class WeatherCompleteDetail extends Equatable {
  const WeatherCompleteDetail({
    required this.weatherDetails,
    required this.weatherForecast,
  });

  final WeatherDetails weatherDetails;
  final WeatherForecast weatherForecast;

  @override
  List<Object?> get props => [weatherDetails, weatherForecast];
}
