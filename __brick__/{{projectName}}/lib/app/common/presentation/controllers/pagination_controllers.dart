import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:{{projectName}}/app/common/domain/models/pagination.dart';

abstract interface class PaginationNotifierAbstract<D, T> {
  AsyncValue<D> get state;
  set state(AsyncValue<D> newState);
  // ignore: deprecated_member_use
  AutoDisposeAsyncNotifierProviderRef<D> get ref;

  Future<void> loadMore();
  bool canLoadMore();
}

/// Use this mixin when using @riverpod
abstract mixin class PaginationNotifierMixin<T>
    implements PaginationNotifierAbstract<PaginatedResult<T>, T> {
  FutureOr<PaginatedResult<T>> loadData(PaginationRequest query);

  @override
  Future<void> loadMore() async {
    final oldState = state;
    if (!oldState.requireValue.hasMore) return;
    state = AsyncLoading<PaginatedResult<T>>().copyWithPrevious(oldState);
    state = await AsyncValue.guard<PaginatedResult<T>>(() async {
      final res = await loadData(oldState.requireValue.nextPage());
      res.items.insertAll(0, state.requireValue.items);
      return res;
    });
  }

  @override
  bool canLoadMore() {
    if (state.isLoading) return false;
    if (!state.hasValue) return false;
    if (!state.requireValue.hasMore) return false;
    return true;
  }
}
