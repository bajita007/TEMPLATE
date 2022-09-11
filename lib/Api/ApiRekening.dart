import 'dart:convert';
import 'dart:ffi';

import 'package:comindors/Api/UrlData.dart';
import 'package:comindors/Model/ModelOutlet.dart';
import 'package:comindors/Ui/StringData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ModekRek.dart';

class ApiRekening extends ChangeNotifier {
  late ModelRekening _modelRekening;

  ModelRekening get modelRekening => _modelRekening;
  List<ModelRekening> _listRekening = [];

  set modelRekening(ModelRekening value) {
    _modelRekening = value;
  }

  List<ModelRekening> get listRekening {
    return [..._listRekening];
  }



  Future<List<ModelRekening>> dataRekening() async {
    List<ModelRekening>? data = [];
    Uri uri = Uri.parse(DataUrl.rekeningList);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    // print(json);
    if (response.statusCode == 200) {
      // data = json['success'];
      if (json['success']) {
        // List a = json["data"];
        data = modelRekeningFromJson(json["data"]);

      } else {
        data = [];
      }
    } else {
      data = [];
    }
    return data;
  }
}
