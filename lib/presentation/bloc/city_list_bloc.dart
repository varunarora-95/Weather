import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:weather/presentation/utils/async_snapshot_cubit.dart';

part 'city_list_state.dart';

class CityListBloc extends FutureAsyncSnapshotCubit<List<CityState>> {
  @override
  FutureOr<List<CityState>> resolve() {
    // TODO: implement resolve
    throw UnimplementedError();
  }
}
