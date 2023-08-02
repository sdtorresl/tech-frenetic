import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/exceptions.dart';
import 'package:techfrenetic/app/models/dtos/vendor_filter_dto.dart';
import 'package:techfrenetic/app/models/dtos/vendor_mapper.dart'
    as vendor_mapper;
import 'package:techfrenetic/app/models/mappers/vendor_description_mapper.dart';
import 'package:techfrenetic/app/models/vendor_description.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import '../models/dtos/paginator_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class VendorsProvider extends TechFreneticProvider {
  Future<VendorDescriptionModel> getVendorDescription() async {
    Uri _url = Uri.parse("$baseUrl/api/$locale/v1/description-vendors");
    var response = await http.get(_url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.jsonDecode(response.body);
      return VendorDescriptionMapper.fromMap(jsonResponse.first);
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    throw ServerException();
  }

  Future<PaginatorDto<VendorModel>> getRecentVendors({int page = 0}) async {
    Uri _url = Uri.parse("$baseUrl/api/$locale/v1/search-supplier");
    var response = await http.get(_url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
      return PaginatorDto.fromMap(jsonResponse, vendor_mapper.fromMap);
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    throw ServerException();
  }

  Future<PaginatorDto<VendorModel>> searchVendors({
    int page = 0,
    required VendorFilterDto filter,
  }) async {
    Uri _url = Uri.parse("$baseUrl/api/$locale/v1/search-supplier");
    _url = _url.replace(queryParameters: filter.getQueryParams);
    debugPrint(_url.toString());
    var response = await http.get(_url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
      var paginator = PaginatorDto.fromMap(jsonResponse, vendor_mapper.fromMap);
      return paginator;
    } else {
      debugPrint('Request failed with status: ${response.statusCode}.');
    }

    throw ServerException();
  }
}
