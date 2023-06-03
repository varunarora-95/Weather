import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/domain/entity/weather_details.dart';
import 'package:weather/presentation/bloc/city_list_bloc.dart';
import 'package:weather/presentation/widgets/forecast_details.dart';

part '../widgets/weather_info_card.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({required this.cityState, super.key});

  final CityState cityState;

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetailsScreen> {
  final horizontalPadding = const EdgeInsets.symmetric(horizontal: 15);

  WeatherDetails get wd => widget.cityState.weatherDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: horizontalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cityState.cityDetails.name!,
                      style: TextStyle(fontSize: 22, color: offWhite),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: offWhite,
                      ),
                      onPressed: Navigator.of(context).pop,
                    )
                  ],
                ),
              ),
              Divider(height: 0.5, color: offWhite),
              const SizedBox(height: 30),
              Padding(
                padding: horizontalPadding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.cityState.weatherDetails.temperature.temp!.toStringAsFixed(0)}$degree',
                      style: TextStyle(fontSize: 60, color: offWhite),
                    ),
                    Text(
                      widget.cityState.weatherDetails.weather.first.main!,
                      style: TextStyle(fontSize: 18, color: offWhite),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: horizontalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _WeatherInfoCard(
                      icon: 'assets/thermometer.png',
                      title: 'Feels like',
                      value:
                          '${(wd.temperature.feelsLike ?? wd.temperature.temp!).toStringAsFixed(0)}$degree',
                    ),
                    _WeatherInfoCard(
                      icon: 'assets/wind.png',
                      title: 'Wind',
                      value: '${wd.wind.speed?.toStringAsFixed(0) ?? 'NA'}km/h',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: horizontalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _WeatherInfoCard(
                      icon: 'assets/humidity.png',
                      title: 'Humidity',
                      value: '${wd.temperature.humidity}%',
                    ),
                    _WeatherInfoCard(
                      icon: 'assets/visibility.png',
                      title: 'Visibility',
                      value: '${(wd.visibility / 1000).toStringAsFixed(0)}km',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ForecastDetails(weatherDetails: wd),
            ],
          ),
        ),
      ),
    );
  }
}
