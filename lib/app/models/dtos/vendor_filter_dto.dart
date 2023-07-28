class VendorFilterDto {
  final String? name;
  final String? location;
  final String? area;
  final String? brand;

  VendorFilterDto({this.name, this.location, this.area, this.brand});

  Map<String, String> get getQueryParams {
    Map<String, String> queryParams = {};
    if (name != null) {
      queryParams['supplier'] = name!;
    }
    if (area != null) {
      queryParams['service'] = area!;
    }
    if (brand != null) {
      queryParams['brand'] = brand!;
    }

    return queryParams;
  }
}
