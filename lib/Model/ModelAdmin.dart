// To parse this JSON data, do
//
//     final modelAdmin = modelAdminFromJson(jsonString);

import 'dart:convert';

List<ModelAdmin> modelAdminFromJson(String str) =>
    List<ModelAdmin>.from(json.decode(str).map((x) => ModelAdmin.fromJson(x)));

String modelAdminToJson(List<ModelAdmin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAdmin {
  ModelAdmin({
    this.id,
    this.nama,
    this.noHp,
    this.noWa,
    this.email,
    this.pass,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? nama;
  String? noHp;
  String? noWa;
  String? email;
  String? pass;
  String? role;
  String? createdAt;
  String? updatedAt;

  factory ModelAdmin.fromJson(Map<String, dynamic> json) => ModelAdmin(
        id: json["id"].toString() ?? "",
        nama: json["nama"] ?? "",
        noHp: json["no_hp"] ?? "",
        noWa: json["no_wa"] ?? "",
        email: json["email"] ?? "",
        pass: json["pass"] ?? "",
        role: json["role"],
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "nama": nama.toString(),
        "no_hp": noHp.toString(),
        "no_wa": noWa.toString(),
        "email": email.toString(),
        "pass": pass.toString(),
        "role": role.toString(),
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
      };
}
