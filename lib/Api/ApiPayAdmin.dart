import 'dart:convert';
import 'dart:ffi';

import 'package:comindors/Api/UrlData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/ModelPayment.dart';

class ApiPayAdmin extends ChangeNotifier {
  late ModelPayment _modelPayment;

  ModelPayment get modelPayment => _modelPayment;
  List<ModelPayment> _listPayment = [];

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

    Uri uri = Uri.parse(
        "${DataUrl.payAllListAdmin}&outlet_id=$outlet_id&status=$dataSts&page=$page");
    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(json);

      if (json['success']) {
        _listPayment = modelPaymentFromJson(json["data"]['data'], "Admin");

        print(_listPayment.length.toString() + " DATA");
      } else {
        _listPayment = [];
      }
    } else {
      _listPayment = [];
    }
    notifyListeners();
    return _listPayment;
  }

  Future<ModelPayment> savePayment({ModelPayment? modelPay}) async {
    ModelPayment data = ModelPayment();
    // print(modelPay?.toJson());

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

  Future<bool> updateAdminPay({ModelPayment? modelPay}) async {
    bool data = false;

    String dataId = modelPay!.id.toString().substring(14);
    modelPay.id = int.parse(dataId).toString();

    final response = await http.post(
      Uri.parse(DataUrl.payAdminUp),
      body: modelPay.toJson(),
    );
    print(modelPay.id);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      data = json['success'];
    }

    return data;
  }
}
