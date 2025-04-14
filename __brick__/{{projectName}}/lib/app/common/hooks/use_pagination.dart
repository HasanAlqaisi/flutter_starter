import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:{{projectName}}/app/common/presentation/controllers/pagination_controllers.dart';

ScrollController usePagination(PaginationNotifierAbstract provider) {
  final scrollController = useScrollController();

  void scrollListener() {
    if (provider.canLoadMore() &&
        scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
      provider.loadMore();
    }
  }

  useEffect(() {
    scrollController.addListener(scrollListener);
    return null;
  }, [scrollController]);

  return scrollController;
}
