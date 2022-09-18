// To parse this JSON data, do
//
//     final modelDetailsPay = modelDetailsPayFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

List<ModelDetailsPay> modelDetailsPayFromJson(String str) =>
    List<ModelDetailsPay>.from(
        json.decode(str).map((x) => ModelDetailsPay.fromJson(x)));

String modelDetailsPayToJson(List<ModelDetailsPay> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDetailsPay {
  ModelDetailsPay({
    this.id,
    this.payId,
    this.outletId,
    this.payPengirim,
    this.payRek,
    this.payTipe,
    this.payImg,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? payId;
  String? outletId;
  String? payPengirim;
  String? payRek;
  String? payTipe;
  String? payImg;
  String? createdAt;
  String? updatedAt;

  factory ModelDetailsPay.fromJson(Map<String, dynamic> json) =>
      ModelDetailsPay(
        id: json["id"].toString(),
        payId: json["pay_id"].toString(),
        outletId: json["outlet_id"].toString(),
        payPengirim: json["pay_pengirim"].toString(),
        payRek: json["pay_rek"].toString(),
        payTipe: json["pay_tipe"].toString(),
        payImg: json["pay_img"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString() ?? '',
        "pay_id": payId ?? '',
        "outlet_id": outletId ?? '',
        "pay_pengirim": payPengirim ?? '',
        "pay_rek": payRek ?? '',
        "pay_tipe": payTipe ?? '',
        "pay_img": payImg ?? '',
        "created_at": createdAt ?? '',
      };
}
