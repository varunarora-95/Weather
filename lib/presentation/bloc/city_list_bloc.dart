import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:weather/domain/entity/city_details.dart';
import 'package:weather/domain/entity/weather_details.dart';
import 'package:weather/domain/repository/weather_repository_impl.dart';
import 'package:weather/presentation/utils/async_snapshot_cubit.dart';
import 'package:weather/presentation/utils/storage_service.dart';

part 'city_list_state.dart';

class CityListBloc extends FutureAsyncSnapshotCubit<List<CityState>>
    with AsyncSnapshotCubitRefreshMixin {
  @override
  FutureOr<List<CityState>> resolve() async {
    final savedCities = await StorageService.getCities();
    if (savedCities != null) {
      final List<CityState> cityStates = [];
      for (final city in savedCities) {
        final weatherDetails =
            await WeatherRepositoryImpl().getCurrentWeather(city.lat!, city.lon!);
        cityStates.add(CityState(cityDetails: city, weatherDetails: weatherDetails));
      }
      return cityStates;
    }

    return <CityState>[];
  }
}
