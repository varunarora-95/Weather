import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/presentation/bloc/city_list_bloc.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({required this.cityState, super.key});

  final CityState cityState;

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetailsScreen> {
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cityState.cityDetails.name!,
                      style: TextStyle(fontSize: 22, color: white),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: white,
                      ),
                      onPressed: Navigator.of(context).pop,
                    )
                  ],
                ),
              ),
              Divider(height: 0.5, color: white),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.cityState.weatherDetails.temperature.temp!.toStringAsFixed(0)}$degree',
                      style: TextStyle(fontSize: 60, color: white),
                    ),
                    Text(
                      widget.cityState.weatherDetails.weather.first.main!,
                      style: TextStyle(fontSize: 18, color: white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
