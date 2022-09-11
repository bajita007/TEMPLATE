import 'dart:convert';
import 'dart:ffi';

import 'package:comindors/Api/UrlData.dart';
import 'package:comindors/Model/ModelOutlet.dart';
import 'package:comindors/Ui/StringData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as  http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiOutlet extends ChangeNotifier {
  late ModelOutlet _modelOutlet;

  ModelOutlet get modelOutlety => _modelOutlet;
  List<ModelOutlet> _listOutlet = [];

  set modelOutlet(ModelOutlet value) {
    _modelOutlet = value;
  }

  List<ModelOutlet> get listlaporan {
    return [..._listOutlet];
  }

  Future<bool> outletLogin({String? id_outlet}) async {
    bool data = false;

    Uri uri = Uri.parse(DataUrl.detailOutlet + id_outlet!);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = json['success'];
      if (json['success']) {
        _modelOutlet = ModelOutlet.fromJson(json['data']);
        saveDataOut(_modelOutlet.outletId.toString(), _modelOutlet.id.toString());
      } else {
        data = false;
      }
    } else {
      data = false;
    }

    return data;
  }

  Future<void> saveDataOut(String idOutlet, String idUser) async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();
    await loginCheck.setString(StringData.id_outlet, idOutlet);
    await loginCheck.setString(StringData.id_user, idUser);
    await loginCheck.setString(StringData.user_status, "outlet");

  }

}
