import 'dart:convert';
import 'dart:ffi';

import 'package:comindors/Api/UrlData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Model/ModelPayment.dart';

class ApiPayment extends ChangeNotifier {
  late ModelPayment _modelPayment;

  ModelPayment get modelPaymenty => _modelPayment;
  List<ModelPayment> _listPayment = [];
  int limitBelanja = 0;
  int limitHarian = 0;

  set modelPayment(ModelPayment value) {
    _modelPayment = value;
  }

  List<ModelPayment> get listPayment {
    return [..._listPayment];
  }

  Future<List<ModelPayment>> riwayatList(
      {required String outlet_id,
      required List status,
      var page = "All"}) async {
    String dataSts = status
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll(" ", "");

    List<ModelPayment>? datapay = [];
    Uri uri = Uri.parse(
        "${DataUrl.payOutlet}?outlet_id=$outlet_id&status=$dataSts&page=$page");
    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (json['success']) {
        datapay = modelPaymentFromJson(json["data"]['data'], '');
        _listPayment = datapay;

        limitBelanja = json["limit"]['LimitBelanja'];
        limitHarian = json["limit"]['LimitHarian'];

      } else {
        datapay = [];
      }
    } else {
      datapay = [];
    }
    notifyListeners();

    return datapay;
  }

  Future<ModelPayment> detailsPay() async {
    ModelPayment data = ModelPayment();
    final response = await http.get(
      Uri.parse(DataUrl.payAdd),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      if (json['success']) {
        data = ModelPayment.fromJson(json['data']);
      }
    }
    return data;
  }

  Future<ModelPayment> savePayment({ModelPayment? modelPay}) async {
    ModelPayment data = ModelPayment();
    final response = await http.post(
      Uri.parse(DataUrl.payAdd),
      body: modelPay?.toJson(),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);

      if (json['success']) {
        data = ModelPayment.fromJson(json['data']);
      }
    }
    return data;
  }
}
