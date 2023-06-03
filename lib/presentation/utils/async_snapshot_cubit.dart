import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart' show AsyncSnapshot, ConnectionState, protected;

export './async_snapshot.dart';
export 'package:flutter/widgets.dart' show AsyncSnapshot, ConnectionState;

/// {@macro async_snapshot_cubit}
///
/// {@macro async_snapshot_future_cubit}
abstract class FutureAsyncSnapshotCubit<T> = _AsyncSnapshotCubit<T>
    with _AsyncSnapshotFutureCubitMixin;

/// {@template async_snapshot_cubit}
/// An abstraction of [Cubit] that exposes an [AsyncSnapshot] of a state [T].
///
/// If `initialState` is provided, the state will only be refreshed on construction if `resolveOnInit` is `true`.
/// Otherwise, the state will be resolved on construction unless `resolveOnInit` is `false`.
///
/// If a manual refresh from the consumer is required, use [AsyncSnapshotCubitRefreshMixin].
/// {@endtemplate}
abstract class _AsyncSnapshotCubit<T> extends Cubit<AsyncSnapshot<T>> {
  _AsyncSnapshotCubit({
    AsyncSnapshot<T>? initialState,
    bool? resolveOnInit,
  }) : super(initialState ??
            ((resolveOnInit ?? initialState == null)
                ? const AsyncSnapshot.waiting()
                : const AsyncSnapshot.nothing())) {
    if (resolveOnInit ?? initialState == null) {
      _resolve(true);
    }
  }

  void emitWithData(T data, [ConnectionState? connectionState]) {
    emit(AsyncSnapshot.withData(connectionState ?? ConnectionState.done, data));
  }

  FutureOr<void> _resolve(bool emitLoading);
}

/// {@macro async_snapshot_future_cubit}
/// Implementers must override [resolve] which will emit an [AsyncSnapshot.data] state and close the connection
/// once resolved.
/// {@endtemplate}
mixin _AsyncSnapshotFutureCubitMixin<T> on _AsyncSnapshotCubit<T> {
  /// Resolves the state of the cubit.
  ///
  /// When called, will emit a [AsyncSnapshot.waiting] state, and then an [AsyncSnapshot.data] state
  /// once resolved.
  ///
  /// If [resolve] throws an [Exception], it will be caught and emitted as an [AsyncSnapshot.error] state.
  @protected
  FutureOr<T> resolve();

  @override
  FutureOr<void> _resolve(bool emitLoading) async {
    if (emitLoading) {
      if (!isClosed) {
        emit(const AsyncSnapshot.waiting());
      }
    }

    try {
      final resolved = await resolve();
      if (!isClosed) {
        emit(AsyncSnapshot.withData(ConnectionState.done, resolved));
      }
    } catch (e, st) {
      if (!isClosed) {
        emit(AsyncSnapshot.withError(ConnectionState.done, e, st));
      }
    }
  }
}

/// Exposes a [refresh] method that forces a [_AsyncSnapshotCubit] to refresh its state.
mixin AsyncSnapshotCubitRefreshMixin<T> on _AsyncSnapshotCubit<T> {
  /// Refreshes the state of the cubit.
  FutureOr<void> refresh({bool emitLoading = true}) => _resolve(emitLoading);
}
