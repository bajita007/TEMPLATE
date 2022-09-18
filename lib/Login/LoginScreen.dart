import 'package:comindors/Api/ApiOutlet.dart';
import 'package:comindors/Login/LoginScreenAdmin.dart';
import 'package:comindors/Page/WelcomePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dialog/LoadingUi.dart';
import '../Ui/ButtonStyle.dart';
import '../Ui/StyleForm.dart';
import '../Ui/StyleText.dart';
import '../Ui/TopHeader.dart';
import '../Ui/Warna.dart';
import '../Ui/circle.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController _outlet_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _outlet_id = TextEditingController(text: "");
    checkLogin();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _outlet_id?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
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
          ClipPath(
            clipper: Header3(),
            child: Container(
              color: Colors.red,
            ),
          ),
          ClipPath(
            clipper: Header2(),
            child: Container(
              color: Warna.BiruPrimary,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Selamat Datang di ',
                        style: StyleText.textBodyPutih16
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        'COMINDO APPS',
                        style: StyleText.textHeaderPutih24
                            .copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                  _loginForm(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ]));
  }

  _loginForm() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              initialValue: {
                'date': DateTime.now(),
                'accept_terms': false,
              },
              child: Column(
                children: <Widget>[
                  Text('Masuk Outlet',
                      textAlign: TextAlign.center,
                      style: StyleText.textSubHeaderHitam20
                          .copyWith(color: Warna.BiruPrimary)),
                  const Divider(),
                  const SizedBox(height: 5),
                  FormBuilderTextField(
                    name: 'outlet_id',
                    decoration: StyleForm.borderInputStyle(
                        title: "ID OUTLET",
                        prefix: const Icon(
                          Icons.phone_android,
                          color: Warna.BiruPrimary,
                        )),

                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),

                    // initialValue: '12',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: StyleButton.buttonPrimary(
                          context: context,
                          navigator: () {
                            loadingUi(context);
                            if (_formKey.currentState!.validate()) {
                              //JIKA TRUE
                              _formKey.currentState!.save();
                              String id_outlet =
                                  _formKey.currentState!.value['outlet_id'];

                              setData(id_outlet);
                            }else{
                              Navigator.of(context).pop();
                            }
                          },
                          title: "Masuk")),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Masuk sebagai admin ? '),
                    TextSpan(
                      text: 'Masuk Admin',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginScreenAdmin()),
                            ),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ]),
    ));
  }

  Future<void> setData(String id_outlet) async {
    await Provider.of<ApiOutlet>(context, listen: false)
        .outletLogin(id_outlet: id_outlet)
        .then((isSuccess) {
      final scaffold = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();

      if (isSuccess) {
        Navigator.of(context)
            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomePage()),
                (Route<dynamic> route) => false);
      } else {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text("Data Outlet Anda Tidak Ditemukan!!!"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  Future<void> checkLogin() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
