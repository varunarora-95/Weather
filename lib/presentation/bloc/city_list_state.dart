part of 'city_list_bloc.dart';

class CityState extends Equatable {
  const CityState({
    required this.cityDetails,
    required this.weatherDetails,
  });

  final CityDetails cityDetails;
  final WeatherDetails weatherDetails;

  @override
  List<Object?> get props => [cityDetails, weatherDetails];
}
