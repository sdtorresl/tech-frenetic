import 'package:techfrenetic/app/models/mappeable.dart';
import 'package:techfrenetic/app/models/model.dart';

class VendorModel implements Model {
  final int id;
  final String picture;
  final String description;
  final String? longDescription;
  final String category;
  final String title;
  final String? author;
  final String? location;
  final List<String> socialNetworks;
  final String? email;
  final String? phone;
  final String? webpage;

  VendorModel({
    required this.id,
    required this.picture,
    required this.description,
    required this.category,
    required this.title,
    this.author,
    this.location,
    required this.socialNetworks,
    this.longDescription,
    this.email,
    this.phone,
    this.webpage,
  });

  @override
  IMappeable fromJson(String json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  IMappeable fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }
}
