import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/dtos/vendor_mapper.dart'
    as vendor_mapper;
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/providers/tf_provider.dart';

import '../models/dtos/paginator_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class VendorsProvider extends TechFreneticProvider {
  Future<PaginatorDto<VendorModel>> getRecentVendors({int page = 0}) async {
    PaginatorDto<VendorModel> paginator = PaginatorDto(
        currentPage: page, itemsPerPage: 0, totalItems: 0, totalPages: 0);
    try {
      Uri _url = Uri.parse("$baseUrl/api/$locale/v1/search-supplier");
      var response = await http.get(_url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.jsonDecode(response.body);
        paginator = PaginatorDto.fromMap(jsonResponse, vendor_mapper.fromMap);
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return paginator;
  }
}
