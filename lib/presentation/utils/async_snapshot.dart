import 'package:flutter/widgets.dart';
import 'package:oxidized/oxidized.dart';

extension AsyncSnapshotX<T> on AsyncSnapshot<T> {
  R when<R>({
    required R Function(T data) data,
    required R Function() loading,
    required R Function(Object err, StackTrace? stackTrace) err,
  }) {
    if (hasData) {
      return data(this.data!);
    } else if (hasError) {
      return err(error!, stackTrace);
    } else {
      return loading();
    }
  }

  R whenLoading<R>({
    required R Function(T? data, bool loading) data,
    required R Function(Object err) err,
  }) {
    if (hasError) {
      return err(error!);
    } else {
      return data(this.data, this.data == null);
    }
  }

  R whenData<R>({
    required R Function(T data) data,
    required R Function() orElse,
  }) {
    return hasData ? data(this.data!) : orElse();
  }
}

extension AsyncSnapshotResultX<T extends Object, E extends Object> on AsyncSnapshot<Result<T, E>> {
  R when<R>({
    required R Function(T data) data,
    required R Function() loading,
    required R Function(E err) err,
  }) {
    if (hasError) {
      // If this throws, make sure ALL errors thrown in your use case are handled using [Result].
      return err(error! as E);
    } else if (hasData) {
      final r = this.data!;

      return r.isOk() ? data(r.unwrap()) : err(r.unwrapErr());
    } else {
      return loading();
    }
  }

  R whenData<R>({
    required R Function(T data) data,
    required R Function() orElse,
  }) =>
      hasData && this.data!.isOk() ? data(this.data!.unwrap()) : orElse();
}
