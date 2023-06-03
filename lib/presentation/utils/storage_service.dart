import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/domain/entity/city_details.dart';

class StorageService {
  static const String _key = 'cities';

  static Future<void> addCity(CityDetails cityDetails) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final savedCities = sharedPreferences.getStringList(_key);
    List<CityDetails> cities = [];
    if (savedCities != null) {
      cities = savedCities.map((cd) => CityDetails.fromJson(json.decode(cd))).toList();
    }
    cities.add(cityDetails);
    final encodedList = cities.map((cd) => json.encode(cd.toJson())).toList();
    await sharedPreferences.setStringList(_key, encodedList);
  }

  static Future<List<CityDetails>?> getCities() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final savedCities = sharedPreferences.getStringList(_key);
    List<CityDetails>? cities;
    if (savedCities != null) {
      cities = savedCities.map((cd) => CityDetails.fromJson(json.decode(cd))).toList();
    }
    return cities;
  }

  static Future<void> removeCity(CityDetails cityDetails) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final savedCities = sharedPreferences.getStringList(_key);
    List<CityDetails> cities = [];
    if (savedCities != null) {
      cities = savedCities.map((cd) => CityDetails.fromJson(json.decode(cd))).toList();
    }
    cities.removeWhere((cd) => cd.lat == cityDetails.lat && cd.lon == cityDetails.lon);
    final encodedList = cities.map((cd) => json.encode(cd.toJson())).toList();
    await sharedPreferences.setStringList(_key, encodedList);
  }
}
