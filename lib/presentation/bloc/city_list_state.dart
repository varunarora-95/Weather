part of 'city_list_bloc.dart';

class CityState extends Equatable {
  const CityState({
    required this.city,
    required this.temperature,
    required this.lat,
    required this.lng,
    required this.weatherCondition,
  });

  final String city, temperature;
  final double lat, lng;
  final int weatherCondition;

  String get weatherDescription => weatherCondition.toString();

  @override
  List<Object?> get props => [
        city,
        temperature,
        lat,
        lng,
        weatherCondition,
      ];
}
