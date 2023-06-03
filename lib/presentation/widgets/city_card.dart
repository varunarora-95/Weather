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
                cityState?.city ?? 'City',
                style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '${cityState?.temperature ?? 'NA'}\u2109',
                style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Text(
            cityState?.weatherDescription ?? 'NA',
            style: TextStyle(color: white, fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
