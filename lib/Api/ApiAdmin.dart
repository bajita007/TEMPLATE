import 'dart:convert';
import 'dart:ffi';

import 'package:comindors/Api/UrlData.dart';
import 'package:comindors/Model/ModelAdmin.dart';
import 'package:comindors/Model/ModelOutlet.dart';
import 'package:comindors/Ui/StringData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/LoginScreen.dart';

class ApiAdmin extends ChangeNotifier {
  late ModelAdmin _modelAdmin;

  ModelAdmin get modelAdmin => _modelAdmin;
  List<ModelAdmin> _listAdmin = [];

  set modelAdmin(ModelAdmin value) {
    _modelAdmin = value;
  }

  List<ModelAdmin> get listAdmin {
    return [..._listAdmin];
  }

  Future<bool> adminLogin({required String email, required String pass, String status =''}) async {
    bool data = false;

    Uri uri = Uri.parse("${DataUrl.adminDetails}?email=$email&pass=$pass");
    final response = await http.get(uri);
    print(response.body);
    print(uri);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      data = json['success'];
      if (json['success']) {
        modelAdmin = ModelAdmin.fromJson(json['data']);
        if(status == ''){
          saveDataOut(modelAdmin);

        }

      } else {
        data = false;
      }
    } else {
      data = false;
    }
  notifyListeners();
    return data;
  }

  Future<void> saveDataOut(ModelAdmin modelAdmin) async {
    SharedPreferences loginCheck = await SharedPreferences.getInstance();
    await loginCheck.setString(StringData.id_user, modelAdmin.id!);
    await loginCheck.setString(StringData.u_name, modelAdmin.email!);
    await loginCheck.setString(StringData.u_pass, modelAdmin.pass!);
    await loginCheck.setString(StringData.user_status, "Admin");
  }

  logOutAdmin(context) async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    getData.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }
}
