import 'package:comindors/Model/ModelAdmin.dart';
import 'package:comindors/Dialog/DialogUi.dart';
import 'package:comindors/Ui/Warna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/ApiAdmin.dart';
import '../Ui/ButtonStyle.dart';
import '../Ui/StringData.dart';
import '../Ui/StyleForm.dart';
import '../Ui/circle.dart';

class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({Key? key}) : super(key: key);

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  ModelAdmin modelAdmin = ModelAdmin();
  TextEditingController c_nama = TextEditingController(text: '');
  late TextEditingController c_email = TextEditingController(text: '');
  late TextEditingController c_nohp = TextEditingController(text: '');
  late TextEditingController c_wa = TextEditingController(text: '');
  bool read = true;
  bool _isFirstLoadRunning = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  getDataUser() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    SharedPreferences getData = await SharedPreferences.getInstance();
    String? email = getData.getString(StringData.u_name);
    String? pass = getData.getString(StringData.u_pass);
    var data = await Provider.of<ApiAdmin>(context, listen: false)
        .adminLogin(email: email!, pass: pass!, status: "OKE");

    if (data) {
      modelAdmin = Provider.of<ApiAdmin>(context, listen: false).modelAdmin;

      setState(() {
        c_nama = TextEditingController(text: modelAdmin.nama);
        c_email = TextEditingController(text: modelAdmin.email);
        c_nohp = TextEditingController(text: modelAdmin.noHp);
        c_wa = TextEditingController(text: modelAdmin.noWa);
        _isFirstLoadRunning = false;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Warna.grey.withAlpha(90),
        appBar: AppBar(
          title: const Text('BIODATA'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Warna.BiruPrimary,
        ),
        body: Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: CustomPaint(
              painter: CircleOne(Colors.blue.withAlpha(80)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomPaint(
              painter: CircleTwo(Colors.red.withAlpha(80)),
            ),
          ),
          Align(
            alignment: const Alignment(1.0, -0.5),
            child: CustomPaint(
              painter: CircleTwo(Colors.red.withAlpha(80)),
            ),
          ),
          Align(
            alignment: const Alignment(-1.0, -0.03),
            child: CustomPaint(
              painter: CircleTwo(Colors.blue.withAlpha(80)),
            ),
          ),
          Align(
            alignment: const Alignment(1.0, 0.3),
            child: CustomPaint(
              painter: CircleTwo(Colors.red.withAlpha(80)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 20.0),
                decoration: const BoxDecoration(
                  color: Warna.BiruPrimary,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/icons/logo.jpg'),
                  ),
                ),
              ),
              Expanded(
                  child: _isFirstLoadRunning
                      ? const Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Warna.BiruPrimary)),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: FormBuilder(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      FormBuilderTextField(
                                        name: 'nama',
                                        readOnly: read,
                                        controller: c_nama,
                                        decoration: StyleForm.borderInputStyle(
                                                title: "Nama",
                                                prefix: const Icon(
                                                  Icons.person,
                                                  color: Warna.BiruPrimary,
                                                ))
                                            .copyWith(
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    StyleForm.borderBiruForm),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 10),
                                      FormBuilderTextField(
                                        name: 'email',
                                        readOnly: read,

                                        controller: c_email,
                                        decoration: StyleForm.borderInputStyle(
                                                title: "Email",
                                                prefix: const Icon(
                                                  Icons.mail,
                                                  color: Warna.BiruPrimary,
                                                ))
                                            .copyWith(
                                                enabled: false,
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    StyleForm.borderBiruForm),

                                        // valueTransformer: (text) => num.tryParse(text),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),

                                        // initialValue: '12',
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 10),
                                      FormBuilderTextField(
                                        name: 'no_hp',
                                        readOnly: read,

                                        controller: c_nohp,
                                        decoration: StyleForm.borderInputStyle(
                                                title: "No Hp",
                                                prefix: const Icon(
                                                  Icons.phone_android,
                                                  color: Warna.BiruPrimary,
                                                ))
                                            .copyWith(
                                                enabled: false,
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    StyleForm.borderBiruForm),

                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),

                                        // initialValue: '12',
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 10),
                                      FormBuilderTextField(
                                        name: 'wa',
                                        readOnly: read,

                                        controller: c_wa,
                                        decoration: StyleForm.borderInputStyle(
                                                title: "WA",
                                                prefix: const Icon(
                                                  Icons.phone_android,
                                                  color: Warna.BiruPrimary,
                                                ))
                                            .copyWith(
                                                enabled: false,
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    StyleForm.borderBiruForm),

                                        // valueTransformer: (text) => num.tryParse(text),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),

                                        // initialValue: '12',
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: StyleButton.buttonPrimary(
                                              context: context,
                                              navigator: () {
                                                if (read) {
                                                  setState(() {
                                                    read = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    read = true;
                                                  });
                                                }
                                              },
                                              title: (read)
                                                  ? "Ubah Profile"
                                                  : "Simpan")),
                                      Visibility(
                                        visible: read,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: StyleButton.buttonPrimary(
                                                context: context,
                                                navigator: () {},
                                                title: "Ganti Kata Sandi")),
                                      ),
                                      Visibility(
                                        visible: read,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: StyleButton.buttonPrimary(
                                                context: context,
                                                navigator: () {
                                                  dialogUi(context,
                                                      oke: "OK",
                                                      title: "Keluar",
                                                      desk:
                                                          'Apakah anda ingin keluar dari aplikasi COMINDO APPS.?',
                                                      navigator: () {
                                                    ApiAdmin()
                                                        .logOutAdmin(context);
                                                  });
                                                },
                                                title: "Keluar",
                                                colors: Colors.red)),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
            ],
          )
        ]));
  }
}
