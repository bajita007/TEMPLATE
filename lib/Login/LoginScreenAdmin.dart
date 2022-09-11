import 'package:comindors/Admin/HomeAdmin.dart';
import 'package:comindors/Page/WelcomePage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../Ui/ButtonStyle.dart';
import '../Ui/StyleForm.dart';
import '../Ui/StyleText.dart';
import '../Ui/TopHeader.dart';
import '../Ui/Warna.dart';
import '../Ui/circle.dart';
import 'LoginScreen.dart';

class LoginScreenAdmin extends StatefulWidget {
  const LoginScreenAdmin({Key? key}) : super(key: key);

  @override
  State<LoginScreenAdmin> createState() => _LoginScreenAdminState();
}

class _LoginScreenAdminState extends State<LoginScreenAdmin> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController _user_admin;
  late TextEditingController _user_pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user_admin = TextEditingController(text: "");
    _user_pass = TextEditingController(text: "");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user_admin?.dispose();
    _user_pass?.dispose();
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
                  Text('Masuk Admin',
                      textAlign: TextAlign.center,
                      style: StyleText.textSubHeaderHitam20
                          .copyWith(color: Warna.BiruPrimary)),
                  const Divider(),
                  const SizedBox(height: 5),
                  FormBuilderTextField(
                    name: 'username',
                    controller: _user_admin,
                    decoration: StyleForm.borderInputStyle(
                        title: "Username",
                        prefix: const Icon(
                          Icons.person,
                          color: Warna.BiruPrimary,
                        )),

                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),

                    // initialValue: '12',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'password',
                    controller: _user_pass,
                    decoration: StyleForm.borderInputStyle(
                        title: "Password",
                        prefix: const Icon(
                          Icons.key,
                          color: Warna.BiruPrimary,
                        )),

                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),

                    // initialValue: '12',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: StyleButton.buttonPrimary(
                          context: context,
                          navigator: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                         HomeAdmin()));
                          },
                          title: "Masuk")),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Masuk sebagai outlet ? '),
                    TextSpan(
                      text: 'Masuk Outlet',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen())),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ]),
    ));
  }
}