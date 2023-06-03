import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/constants.dart';
import 'package:weather/domain/entity/weather_details.dart';
import 'package:weather/domain/entity/weather_forecast.dart';
import 'package:weather/presentation/bloc/weather_forecast_detail_bloc.dart';
import 'package:weather/presentation/utils/async_snapshot.dart';
import 'package:weather/presentation/widgets/loading_shimmer.dart';

final now = DateTime.now().toUtc();

class ForecastDetails extends StatelessWidget {
  ForecastDetails({required this.weatherDetails, Key? key}) : super(key: key);

  final WeatherDetails weatherDetails;

  late final _bloc =
      WeatherForecastDetailBloc(weatherDetails.coordinates!.lat, weatherDetails.coordinates!.lon);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            BlocBuilder<WeatherForecastDetailBloc, AsyncSnapshot<WeatherForecast>>(
              bloc: WeatherForecastDetailBloc(
                  weatherDetails.coordinates!.lat, weatherDetails.coordinates!.lon),
              builder: (_, state) => state.when(
                data: (data) => RefreshIndicator(
                  onRefresh: () async => _bloc.refresh(),
                  child: _ForecastListWidget(
                    currentWeather: weatherDetails,
                    timezoneOffset: weatherDetails.timezone!.toInt(),
                    forecast: data,
                  ),
                ),
                err: (err, _) => Text(err.toString()),
                loading: () => LoadingShimmer(
                  loading: true,
                  child: _ForecastListWidget(
                    currentWeather: weatherDetails,
                    timezoneOffset: weatherDetails.timezone!.toInt(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Divider(height: 0.5, color: offWhite),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('5-day weather forecast', style: TextStyle(color: offWhite)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForecastListWidget extends StatelessWidget {
  const _ForecastListWidget({
    required this.timezoneOffset,
    required this.currentWeather,
    this.forecast,
    Key? key,
  }) : super(key: key);

  final int timezoneOffset;
  final WeatherDetails currentWeather;
  final WeatherForecast? forecast;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      shrinkWrap: true,
      itemBuilder: (_, i) {
        String day = 'NA', temperature = 'NA', maxMin = 'NA$degree/NA$degree';
        if (forecast != null) {
          final currentLocalTime = now.add(Duration(seconds: timezoneOffset));
          final indexedDate = currentLocalTime.add(Duration(days: i));
          final startTime = DateTime(indexedDate.year, indexedDate.month, indexedDate.day);
          final endTime = DateTime(indexedDate.year, indexedDate.month, indexedDate.day, 23, 59);

          final weatherReports = forecast!.weatherDetails.where((wd) =>
              wd.dateTime != null &&
              wd.dateTime!.isBefore(endTime) &&
              wd.dateTime!.isAfter(startTime));

          final differenceInDays = indexedDate.difference(currentLocalTime).inDays;
          switch (differenceInDays) {
            case 0:
              day = 'Today';
              break;
            case 1:
              day = 'Tomorrow';
              break;
            default:
              day = DateFormat('EEE').format(indexedDate);
          }
          num? max, min;
          Map<String, int> countMap = {};
          for (final wd in weatherReports) {
            if (max == null || max < wd.temperature.tempMax!) {
              max = wd.temperature.tempMax!;
            }
            if (min == null || min > wd.temperature.tempMin!) {
              min = wd.temperature.tempMin!;
            }
            countMap[wd.weather.first.main!] = (countMap[wd.weather.first.main!] ?? 0) + 1;
          }

          if (countMap.isEmpty) {
            countMap[currentWeather.weather.first.main!] = 1;
            max = currentWeather.temperature.tempMax;
            min = currentWeather.temperature.tempMin;
          }

          temperature = countMap.length > 1
              ? countMap.entries
                  .reduce((prev, current) => prev.value > current.value ? prev : current)
                  .key
              : countMap.isNotEmpty
                  ? countMap.keys.first
                  : '';
          maxMin = '${max?.toStringAsFixed(0)}$degree/${min?.toStringAsFixed(0)}$degree';
        }

        return Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(day),
            ),
            const Spacer(),
            Text(temperature),
            const Spacer(),
            Container(
              width: 100,
              alignment: Alignment.centerRight,
              child: Text(maxMin),
            ),
          ],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: 5,
    );
  }
}
