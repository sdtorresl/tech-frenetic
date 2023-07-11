// To parse this JSON data, do
//
//     final vendorDto = vendorDtoFromJson(jsonString);

import 'dart:convert';

class PartnerDto {
  final String? body;
  final List<dynamic>? customSocialNewtwork;
  final String? fieldBrandVendors;
  final String? fieldCorreo;
  final String? fieldCountry;
  final String? fieldPhone;
  final String? fieldPhoto;
  final String? fieldRedesSociales;
  final String? fieldServicesVendors;
  final String? fieldSitioWeb;
  final String? fieldSlogan;
  final String? fieldTitleBody;
  final String? nid;
  final String? tid;
  final String? tid1;
  final String? title;

  PartnerDto({
    this.body,
    this.customSocialNewtwork,
    this.fieldBrandVendors,
    this.fieldCorreo,
    this.fieldCountry,
    this.fieldPhone,
    this.fieldPhoto,
    this.fieldRedesSociales,
    this.fieldServicesVendors,
    this.fieldSitioWeb,
    this.fieldSlogan,
    this.fieldTitleBody,
    this.nid,
    this.tid,
    this.tid1,
    this.title,
  });

  factory PartnerDto.fromRawJson(String str) =>
      PartnerDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartnerDto.fromJson(Map<String, dynamic> json) => PartnerDto(
        body: json["body"],
        customSocialNewtwork: json["custom_social_newtwork"] == null
            ? []
            : List<dynamic>.from(json["custom_social_newtwork"]!.map((x) => x)),
        fieldBrandVendors: json["field_brand_vendors"],
        fieldCorreo: json["field_correo"],
        fieldCountry: json["field_country"],
        fieldPhone: json["field_phone"],
        fieldPhoto: json["field_photo"],
        fieldRedesSociales: json["field_redes_sociales"],
        fieldServicesVendors: json["field_services_vendors"],
        fieldSitioWeb: json["field_sitio_web"],
        fieldSlogan: json["field_slogan"],
        fieldTitleBody: json["field_title_body"],
        nid: json["nid"],
        tid: json["tid"],
        tid1: json["tid_1"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "custom_social_newtwork": customSocialNewtwork == null
            ? []
            : List<dynamic>.from(customSocialNewtwork!.map((x) => x)),
        "field_brand_vendors": fieldBrandVendors,
        "field_correo": fieldCorreo,
        "field_country": fieldCountry,
        "field_phone": fieldPhone,
        "field_photo": fieldPhoto,
        "field_redes_sociales": fieldRedesSociales,
        "field_services_vendors": fieldServicesVendors,
        "field_sitio_web": fieldSitioWeb,
        "field_slogan": fieldSlogan,
        "field_title_body": fieldTitleBody,
        "nid": nid,
        "tid": tid,
        "tid_1": tid1,
        "title": title,
      };
}
