import 'package:techfrenetic/app/models/model.dart';

class VendorModel extends Model {
  final int id;
  final String category;
  final String description;
  final String title;
  final String? author;
  final String? email;
  final String? location;
  final String? longDescription;
  final String? phone;
  final String? picture;
  final String? webpage;

  VendorModel({
    required this.category,
    required this.description,
    required this.id,
    required this.title,
    this.author,
    this.email,
    this.location,
    this.longDescription,
    this.phone,
    this.picture,
    this.webpage,
  });
}
