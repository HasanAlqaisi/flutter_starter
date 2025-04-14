import 'package:dart_mappable/dart_mappable.dart';
import 'package:{{projectName}}/core/constants/app_strings.dart';

part 'pagination.mapper.dart';

@MappableClass()
class PaginationRequest with PaginationRequestMappable {
  final int page;
  final int perPage;

  PaginationRequest({required this.page, required this.perPage});
}

@MappableClass()
class PaginatedResult<T> with PaginatedResultMappable<T> {
  final List<T> items;
  final int total;
  final int currentPage;

  int get totalPages => (total / AppStrings.perPage).ceil();
  bool get hasMore => currentPage < totalPages;

  PaginationRequest nextPage() {
    return PaginationRequest(
      page: currentPage + 1,
      perPage: AppStrings.perPage,
    );
  }

  PaginatedResult({
    required this.items,
    required this.currentPage,
    required this.total,
  });
}
