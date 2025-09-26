import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trend/app/common/domain/models/pagination.dart';
import 'package:trend/app/common/widgets/error_card.dart';
import 'package:trend/core/failures/base_failure.dart';

/// this is a wrapper widget that will handle the state of the async value
class AsyncWidget<T> extends HookWidget {
  const AsyncWidget({
    required this.asyncValue,
    required this.builder,
    super.key,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.onRetry,
    this.showRefreshLoading = false,
  });
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) builder;
  final Widget Function(Object error, Widget errorBuild)? errorBuilder;

  /// only works if data is list and empty
  final Widget Function()? emptyBuilder;
  final Widget Function()? loadingBuilder;
  final VoidCallback? onRetry;

  /// show loading when async value is loading and we also have a value exist
  final bool showRefreshLoading;

  static Widget sliver<T>({
    required AsyncValue<T> asyncValue,
    required Widget Function(T data) builder,
    Widget Function(Object error, Widget errorBuild)? errorBuilder,
    Widget Function()? emptyBuilder,
    Widget Function()? loadingBuilder,
    VoidCallback? onRetry,
    bool showRefreshLoading = false,
  }) {
    return SliverToBoxAdapter(
      child: AsyncWidget<T>(
        asyncValue: asyncValue,
        builder: builder,
        errorBuilder: errorBuilder,
        emptyBuilder: emptyBuilder,
        loadingBuilder: loadingBuilder,
        onRetry: onRetry,
        showRefreshLoading: showRefreshLoading,
      ),
    );
  }

  static Widget paginated<T>({
    required AsyncValue<PaginatedResult<T>> asyncValue,
    required Widget Function(List<T> data) builder,
    Widget Function(Object error, Widget errorBuild)? errorBuilder,
    Widget Function()? emptyBuilder,
    Widget Function()? loadingBuilder,
    VoidCallback? onRetry,
    bool showRefreshLoading = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AsyncWidget<PaginatedResult<T>>(
          asyncValue: asyncValue,
          builder: (data) => data.items.isEmpty
              ? emptyBuilder?.call() ?? SizedBox.shrink()
              : builder(data.items),
          errorBuilder: errorBuilder,
          emptyBuilder: emptyBuilder,
          loadingBuilder: loadingBuilder,
          onRetry: onRetry,
          showRefreshLoading: showRefreshLoading,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wrap(Widget child) {
      return child;
    }

    final errorBuilder =
        this.errorBuilder ?? (error, errorBuild) => wrap(errorBuild);

    bool isEmpty(T val) {
      if (val is List) {
        return val.isEmpty;
      }
      if (val is PaginatedResult) {
        return val.items.isEmpty;
      }
      return false;
    }

    final child = switch (asyncValue) {
      AsyncLoading() => wrap(
        Padding(
          padding: EdgeInsets.all(8),
          child:
              loadingBuilder?.call() ??
              const Center(child: CircularProgressIndicator()),
        ),
      ),
      final AsyncData val when val.isLoading && showRefreshLoading => wrap(
        Padding(
          padding: EdgeInsets.all(8),
          child:
              loadingBuilder?.call() ??
              const Center(child: CircularProgressIndicator()),
        ),
      ),
      AsyncError(error: final error) => errorBuilder.call(
        error,
        ErrorCard(
          isLoading: asyncValue.isLoading,
          error: handleErrorMessage(error),
          onRetry: asyncValue.isLoading ? null : onRetry,
        ),
      ),
      AsyncData(value: final value)
          when emptyBuilder != null && isEmpty(value) =>
        emptyBuilder!(),
      AsyncData(value: final value) => builder(value),
    };

    return child;
  }
}
