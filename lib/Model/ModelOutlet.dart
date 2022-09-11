// To parse this JSON data, do
//
//     final modelOutlet = modelOutletFromJson(jsonString);

import 'dart:convert';

List<ModelOutlet> modelOutletFromJson(String str) => List<ModelOutlet>.from(
    json.decode(str).map((x) => ModelOutlet.fromJson(x)));

String modelOutletToJson(List<ModelOutlet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelOutlet {
  ModelOutlet({
     this.id,
     this.kabupaten,
     this.kecamatan,
     this.outletId,
     this.outletNama,
     this.noRs,
     this.fisik,
     this.salesForce,
     this.tapRetail,
     this.hariKunjungan,
  });

  int? id;
  String? kabupaten;
  String? kecamatan;
  String? outletId;
  String? outletNama;
  String? noRs;
  String? fisik;
  String? salesForce;
  String? tapRetail;
  String? hariKunjungan;

  factory ModelOutlet.fromJson(Map<String, dynamic> json) => ModelOutlet(
        id: json["id"],
        kabupaten: json["kabupaten"],
        kecamatan: json["kecamatan"],
        outletId: json["outlet_id"],
        outletNama: json["outlet_nama"],
        noRs: json["no_rs"],
        fisik: json["fisik"],
        salesForce: json["sales_force"],
        tapRetail: json["tap_retail"],
        hariKunjungan: json["hari_kunjungan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kabupaten": kabupaten ?? "",
        "kecamatan": kecamatan ?? "",
        "outlet_id": outletId ?? "",
        "outlet_nama": outletNama ?? "",
        "no_rs": noRs ?? "",
        "fisik": fisik ?? "",
        "sales_force": salesForce ?? "",
        "tap_retail": tapRetail ?? "",
        "hari_kunjungan": hariKunjungan ?? "",
      };
}
