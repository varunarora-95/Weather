import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/bloc/city_list_bloc.dart';
import 'package:weather/presentation/utils/async_snapshot.dart';
import 'package:weather/presentation/widgets/city_card.dart';
import 'package:weather/presentation/widgets/loading_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<CityListBloc, AsyncSnapshot<List<CityState>>>(
        bloc: CityListBloc(),
        builder: (_, state) => state.when(
          data: (data) => ListView.separated(
            itemBuilder: (_, i) {
              return CityCard(cityState: data.elementAt(i));
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: data.length,
          ),
          err: (err, _) => Text(err.toString()),
          loading: () => LoadingShimmer(
            loading: true,
            child: ListView.separated(
              itemBuilder: (_, __) {
                return const CityCard(cityState: null);
              },
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: 5,
            ),
          ),
        ),
      ),
    );
  }
}
