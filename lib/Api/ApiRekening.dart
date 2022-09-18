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

  Future<List<ModelRekening>> dataRekening({String status = ""}) async {
    List<ModelRekening>? data = [];
    Uri uri = Uri.parse("${DataUrl.rekeningList}?status=$status");
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    // print(json);
    if (response.statusCode == 200) {
      if (json['success']) {
        data = modelRekeningFromJson(json["data"]);
        if (status.contains('admin')) {
          _listRekening = data;

          notifyListeners();
        }
      } else {
        data = [];
      }
    } else {
      data = [];
    }
    return data;
  }

  Future<bool> deleteRek({required ModelRekening modelRekening}) async {
    bool data = false;
    Uri uri = Uri.parse(
        "${DataUrl.rekeningDel}?delete_id=${modelRekening.id.toString()}");
    final response = await http.delete(uri);
    final json = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      if (json['success']) {
        _listRekening.remove(modelRekening);
        notifyListeners();
        data = true;
      } else {
        data = false;
      }
    } else {
      data = false;
    }
    return data;
  }

  Future<ModelRekening> tambahRek({ModelRekening? modelRekening}) async {
    ModelRekening data = ModelRekening();
    print(modelRekening?.toJson());

    final response = await http.post(
      Uri.parse(DataUrl.rekeningAdd),
      body: modelRekening?.toJson(),
    );

    print(response.body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);

      if (json['success']) {
        data = ModelRekening.fromJson(json['data']);
        _listRekening.add(data);

        notifyListeners();
      }
    }

    return data;
  }
}
