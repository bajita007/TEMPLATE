import 'package:flutter/material.dart';

import '../Ui/StyleText.dart';
import '../Ui/Warna.dart';

class WelcomeAdmin extends StatefulWidget {
  const WelcomeAdmin({Key? key}) : super(key: key);

  @override
  State<WelcomeAdmin> createState() => _WelcomeAdminState();
}

class _WelcomeAdminState extends State<WelcomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: logo(25),
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.logout_rounded,
                color: Warna.BiruPrimary,
              ),
            ),
          )
        ],
      ),
      body: Text("OKE"),
    );
  }
}
