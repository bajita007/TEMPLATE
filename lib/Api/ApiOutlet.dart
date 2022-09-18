import 'dart:convert';
import 'dart:ffi';

import 'package:comindors/Api/UrlData.dart';
import 'package:comindors/Model/ModelOutlet.dart';
import 'package:comindors/Ui/StringData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiOutlet extends ChangeNotifier {
  ModelOutlet _modelOutlet = ModelOutlet();

  ModelOutlet get modelOutlet => _modelOutlet;
  List<ModelOutlet> _listOutlet = [];

  set modelOutlet(ModelOutlet value) {
    _modelOutlet = value;
  }

  List<ModelOutlet> get listOutlet {
    return [..._listOutlet];
  }

  Future<bool> outletLogin({String? id_outlet, bool setModel = false}) async {
    bool data = false;
    // if (setModel) {
    //   data = ModelOutlet();
    // } else {
    //
    // }

    Uri uri = Uri.parse(DataUrl.detailOutlet + id_outlet!);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (json['success']) {
        var oke = ModelOutlet.fromJson(json['data']);
        _modelOutlet = oke;
        notifyListeners();
        // if (setModel) {
        //   data = oke;
        // } else {
        data = json['success'];
        if (!setModel) {
          saveDataOut(
              _modelOutlet.outletId.toString(), _modelOutlet.id.toString());
        }
        // }
      }
    }
    return data;
  }



  Future<void> saveDataOut(String idOutlet, String idUser) async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();
    await loginCheck.setString(StringData.id_outlet, idOutlet);
    await loginCheck.setString(StringData.id_user, idUser);
    await loginCheck.setString(StringData.user_status, "Outlet");
  }
}
