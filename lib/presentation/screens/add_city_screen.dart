import 'package:flutter/material.dart';
import 'package:weather/constants.dart';
import 'package:weather/domain/entity/city_details.dart';
import 'package:weather/domain/repository/weather_repository_impl.dart';
import 'package:weather/presentation/utils/storage_service.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final _textEditingController = TextEditingController();
  final List<CityDetails> cities = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          TextField(
            controller: _textEditingController,
            onChanged: (_) => setState(() {}),
            onSubmitted: (query) async {
              final res = await WeatherRepositoryImpl().getCity(query);
              cities
                ..clear()
                ..addAll(res);
              setState(() {});
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search city',
              suffix: InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.green[400]),
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 0.5, color: offWhite),
          const SizedBox(height: 15),
          if (_textEditingController.text.isNotEmpty && cities.isEmpty) ...[
            const Center(
              child: Text('Tap enter to search online.'),
            ),
          ],
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (_, i) {
              final cityDetail = cities.elementAt(i);
              String label = cityDetail.name!;
              if (cityDetail.state != null) {
                label = '$label, ${cityDetail.state!}';
              }
              if (cityDetail.country != null) {
                label = '$label, ${cityDetail.country!}';
              }

              return InkWell(
                onTap: () async {
                  await StorageService.addCity(cityDetail);
                  if (mounted) Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(label),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: cities.length,
          ),
        ],
      ),
    );
  }
}
