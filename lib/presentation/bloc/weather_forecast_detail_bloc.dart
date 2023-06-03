import 'dart:async';

import 'package:weather/domain/repository/weather_repository_impl.dart';
import 'package:weather/presentation/utils/async_snapshot_cubit.dart';

import '../../domain/entity/weather_forecast.dart';

class WeatherForecastDetailBloc extends FutureAsyncSnapshotCubit<WeatherForecast>
    with AsyncSnapshotCubitRefreshMixin {
  WeatherForecastDetailBloc(this.lat, this.lon);

  final double lat, lon;

  @override
  FutureOr<WeatherForecast> resolve() => WeatherRepositoryImpl().getForecast(lat, lon);
}
