// To parse this JSON data, do
//
//     final modelPayment = modelPaymentFromJson(jsonString);

import 'dart:convert';

import 'package:comindors/Model/ModelOutlet.dart';
import 'package:intl/intl.dart';

List<ModelPayment> modelPaymentFromJson(List str, String? status) {
  if (status == "Admin") {
    return List<ModelPayment>.from(
        str.map((x) => ModelPayment.fromJsonAdmin(x)));
  } else {
    return List<ModelPayment>.from(str.map((x) => ModelPayment.fromJson(x)));
  }
}

String modelPaymentToJson(List<ModelPayment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPayment {
  ModelPayment({
    this.id,
    this.outletId,
    this.payStatus,
    this.payDeposit,
    this.payTotal,
    this.payUnik,
    this.idCmdRekening,
    this.createdAt,
    this.updatedAt,
    this.outlet,
  });

  String? id;
  String? outletId;
  String? payStatus;
  String? payDeposit;
  String? payTotal;
  String? payUnik;
  String? idCmdRekening;
  String? createdAt;
  String? updatedAt;
  ModelOutlet? outlet;

  factory ModelPayment.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json["created_at"].toString());
    DateTime dateUp = DateTime.parse(json["updated_at"].toString());
    String dateString = DateFormat('yyMMddhhss').format(date);
    String dateFormat2 = DateFormat('dd-MMM-yyyy HH:ss').format(date);
    String dateUpdate = DateFormat('dd-MMM-yyyy HH:ss').format(dateUp);

    final formatter2 =
        NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0);
    NumberFormat formatter = NumberFormat("000000");
    String idData = formatter.format(int.parse(json["id"].toString()));
    String data = "CMD-$dateString$idData";

    return ModelPayment(
      id: data,
      outletId: json["outlet_id"].toString(),
      payStatus: json["pay_status"].toString(),
      payDeposit: formatter2
          .format(int.parse(json["pay_deposit"].toString()))
          .replaceAll("Rp", "Rp "),
      payTotal: formatter2
          .format(int.parse(json["pay_total"].toString()))
          .replaceAll("Rp", "Rp "),
      payUnik: formatter2
          .format(int.parse(json["pay_unik"].toString()))
          .replaceAll("Rp", "Rp "),
      idCmdRekening: json["id_cmd_rekening"].toString(),
      createdAt: dateFormat2,
      updatedAt: dateUpdate,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "outlet_id": outletId,
        "pay_status": payStatus,
        "pay_deposit": payDeposit,
        "pay_total": payTotal,
        "pay_unik": payUnik,
        "id_cmd_rekening": idCmdRekening,
        "created_at": createdAt.toString() ?? "",
        "updated_at": updatedAt.toString() ?? "",
      };

  factory ModelPayment.fromJsonAdmin(Map<String, dynamic> json) {
    DateTime date = DateTime.parse(json["created_at"].toString());
    DateTime dateUp = DateTime.parse(json["updated_at"].toString());
    String dateString = DateFormat('yyMMddhhss').format(date);
    String dateFormat2 = DateFormat('dd-MMM-yyyy HH:ss').format(date);
    String dateUpdate = DateFormat('dd-MMM-yyyy HH:ss').format(dateUp);

    final formatter2 =
        NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0);
    NumberFormat formatter = NumberFormat("000000");
    String idData = formatter.format(int.parse(json["id"].toString()));
    String data = "CMD-$dateString$idData";

    return ModelPayment(
      id: data,
      outletId: json["outlet_id"],
      payStatus: json["pay_status"].toString(),
      payDeposit: formatter2
          .format(int.parse(json["pay_deposit"].toString()))
          .replaceAll("Rp", "Rp "),
      payTotal: formatter2
          .format(int.parse(json["pay_total"].toString()))
          .replaceAll("Rp", "Rp "),
      payUnik: formatter2
          .format(int.parse(json["pay_unik"].toString()))
          .replaceAll("Rp", "Rp "),
      idCmdRekening: json["id_cmd_rekening"].toString(),
      createdAt: dateFormat2,
      updatedAt: dateUpdate,
      outlet: ModelOutlet.fromJson(json["outlet"]),
    );
  }
}
