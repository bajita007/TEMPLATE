import 'dart:convert';
import 'dart:io';

import 'package:comindors/Api/UrlData.dart';
import 'package:comindors/Model/ModelDetailsPayment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPayDetails extends ChangeNotifier {
  late ModelDetailsPay _modelDetailsPay;

  set modelPayment(ModelDetailsPay value) {
    _modelDetailsPay = value;
  }

  Future<ModelDetailsPay> addPayDetails(
      {ModelDetailsPay? modelPay, File? file}) async {
    ModelDetailsPay data = ModelDetailsPay();
    if (file != null) {
      String base64Image = base64Encode(file!.readAsBytesSync());

      modelPay?.payImg = base64Image;
    }

    final response = await http.post(
      Uri.parse(DataUrl.tambahDetailsPay),
      body: modelPay?.toJson(),
    );

    print(response.body);

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);

      if (json['success']) {
        data = ModelDetailsPay.fromJson(json['data']);
      }
    }

    return data;
  }
}
