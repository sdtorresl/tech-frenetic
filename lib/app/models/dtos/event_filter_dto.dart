import 'package:techfrenetic/app/core/extensions/datetime_utils.dart';

class EventFilterDto {
  final String? name;
  final DateTime? startDate;
  final String? category;

  EventFilterDto({this.name, this.startDate, this.category});

  Map<String, String> get getQueryParams {
    Map<String, String> queryParams = {};
    if (name != null) {
      queryParams['name'] = name!;
    }
    if (startDate != null) {
      queryParams['date'] = startDate!.toDateString();
    }
    if (category != null) {
      queryParams['category'] = category!;
    }

    return queryParams;
  }
}
