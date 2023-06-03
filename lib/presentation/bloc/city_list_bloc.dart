import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/domain/entity/city_details.dart';
import 'package:weather/domain/entity/weather_details.dart';
import 'package:weather/domain/repository/weather_repository_impl.dart';
import 'package:weather/presentation/utils/async_snapshot_cubit.dart';

part 'city_list_state.dart';

class CityListBloc extends FutureAsyncSnapshotCubit<List<CityState>>
    with AsyncSnapshotCubitRefreshMixin {
  @override
  FutureOr<List<CityState>> resolve() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final savedCities = sharedPreferences.getStringList('cities');
    if (savedCities != null) {
      final cities = savedCities.map((cd) => CityDetails.fromJson(json.decode(cd))).toList();
      final List<CityState> cityStates = [];
      for (final city in cities) {
        final weatherDetails =
            await WeatherRepositoryImpl().getCurrentWeather(city.lat!, city.lon!);
        cityStates.add(CityState(cityDetails: city, weatherDetails: weatherDetails));
      }
      return cityStates;
    }

    return <CityState>[];
  }
}
