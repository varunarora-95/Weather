import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather/constants.dart';
import 'package:weather/presentation/bloc/city_list_bloc.dart';
import 'package:weather/presentation/screens/add_city_screen.dart';
import 'package:weather/presentation/screens/weather_details_screen.dart';
import 'package:weather/presentation/utils/async_snapshot.dart';
import 'package:weather/presentation/utils/storage_service.dart';
import 'package:weather/presentation/widgets/city_card.dart';
import 'package:weather/presentation/widgets/loading_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = CityListBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet<bool?>(
          context: context,
          builder: (_) => const AddCityScreen(),
        ).then((value) => {
              if (value ?? false) {_bloc.refresh(emitLoading: false)}
            }),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      primary: true,
      body: SafeArea(
        top: true,
        child: BlocBuilder<CityListBloc, AsyncSnapshot<List<CityState>>>(
          bloc: _bloc,
          builder: (_, state) => state.when(
            data: (data) => data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/map.png'),
                        const SizedBox(height: 5),
                        Text(
                          'No cities added',
                          style: TextStyle(color: offWhite, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async => _bloc.refresh(),
                    child: _CityListWidget(
                      cities: data,
                      onDelete: (i) async {
                        await StorageService.removeCity(data.elementAt(i).cityDetails);
                        _bloc.refresh(emitLoading: false);
                      },
                    ),
                  ),
            err: (err, _) => Text(err.toString()),
            loading: () => const LoadingShimmer(
              loading: true,
              child: _CityListWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

typedef OnDelete = Future<bool>? Function(int);

class _CityListWidget extends StatelessWidget {
  const _CityListWidget({this.cities, this.onDelete, Key? key}) : super(key: key);

  final List<CityState>? cities;
  final Function(int)? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      itemBuilder: (_, i) => InkWell(
        onTap: () => cities != null
            ? showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => WeatherDetailsScreen(
                  cityState: cities!.elementAt(i),
                ),
              )
            : null,
        child: cities != null
            ? Slidable(
                key: Key(cities!.elementAt(i).cityDetails.name!),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) => onDelete?.call(i),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      borderRadius: BorderRadius.circular(10),
                      label: 'Delete',
                    ),
                  ],
                ),
                child: CityCard(cityState: cities!.elementAt(i)),
              )
            : const CityCard(cityState: null),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: cities?.length ?? 5,
    );
  }
}
