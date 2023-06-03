import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:weather/domain/repository/weather_repository_impl.dart';
import 'package:weather/presentation/utils/async_snapshot_cubit.dart';

import '../../domain/entity/weather_details.dart';
import '../../domain/entity/weather_forecast.dart';

part 'weather_complete_detail_state.dart';

class WeatherCompleteDetailBloc extends FutureAsyncSnapshotCubit<WeatherCompleteDetail>
    with AsyncSnapshotCubitRefreshMixin {
  WeatherCompleteDetailBloc(this.weatherDetails);

  final WeatherDetails weatherDetails;

  @override
  FutureOr<WeatherCompleteDetail> resolve() async {
    final forecast = await WeatherRepositoryImpl()
        .getForecast(weatherDetails.coordinates!.lat, weatherDetails.coordinates!.lon);

    return WeatherCompleteDetail(weatherDetails: weatherDetails, weatherForecast: forecast);
  }
}
