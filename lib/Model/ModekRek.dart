// To parse this JSON data, do
//
//     final modelRekening = modelRekeningFromJson(jsonString);

import 'dart:convert';

List<ModelRekening> modelRekeningFromJson(List str) => List<ModelRekening>.from(str.map((x) => ModelRekening.fromJson(x)));

String modelRekeningToJson(List<ModelRekening> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelRekening {
  ModelRekening({
    this.id,
    this.tipeRek,
    this.noRek,
    this.namaRek,
  });

  int? id;
  String? tipeRek;
  String? noRek;
  String? namaRek;

  factory ModelRekening.fromJson(Map<String, dynamic> json) => ModelRekening(
    id: json["id"]??"",
    tipeRek: json["tipe_rek"]??"",
    noRek: json["no_rek"]??"",
    namaRek: json["nama_rek"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipe_rek": tipeRek,
    "no_rek": noRek,
    "nama_rek": namaRek,
  };
}
