import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/presentation/bloc/city_list_bloc.dart';

class CityCard extends StatelessWidget {
  const CityCard({required this.cityState, super.key});

  final CityState? cityState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cityState?.cityDetails.name ?? 'City',
                style: TextStyle(color: offWhite, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '${cityState?.weatherDetails.temperature.temp?.toStringAsFixed(0) ?? 'NA'}$degree',
                style: TextStyle(color: offWhite, fontSize: 16),
              ),
            ],
          ),
          Text(
            cityState?.weatherDetails.weather.first.main ?? 'NA',
            style: TextStyle(color: offWhite, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
