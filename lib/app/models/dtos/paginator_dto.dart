import 'package:techfrenetic/app/models/mappeable.dart';

class PaginatorDto<T extends IMappeable> {
  int currentPage;
  int totalItems;
  int itemsPerPage;
  int totalPages;
  List<T> items;
  PaginatorDto<T> Function()? nextItems;

  PaginatorDto(
      {required this.totalItems,
      required this.itemsPerPage,
      required this.totalPages,
      required this.currentPage,
      this.items = const [],
      this.nextItems});

  factory PaginatorDto.fromMap(
          Map<String, dynamic> json, T Function(Map<String, dynamic>) mapper) =>
      PaginatorDto(
        currentPage: json["pager"]["current_page"],
        totalItems: json["pager"]["total_items"],
        totalPages: json["pager"]["total_pages"],
        itemsPerPage: json["pager"]["items_per_page"],
        items: List<T>.from(json["rows"].map((x) => mapper.call(x))),
      );

  bool hasNext() => currentPage + 1 < totalPages;

  bool hasPrevious() => currentPage > 0;

  List<T> getNext() {
    if (nextItems != null) {
      PaginatorDto<T> paginator = nextItems!();
      currentPage = paginator.currentPage;
      totalItems = paginator.totalItems;
      totalPages = paginator.totalPages;
      items = paginator.items;
      itemsPerPage = paginator.itemsPerPage;
      nextItems = paginator.nextItems;
    }
    return items;
  }
}
