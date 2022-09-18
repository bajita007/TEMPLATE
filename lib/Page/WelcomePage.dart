import 'dart:ffi';

import 'package:comindors/Api/ApiOutlet.dart';
import 'package:comindors/Api/ApiPay.dart';
import 'package:comindors/Login/LoginScreen.dart';
import 'package:comindors/Model/ModelOutlet.dart';
import 'package:comindors/Page/RiwayatPage.dart';
import 'package:comindors/Page/TopupPage.dart';
import 'package:comindors/Ui/ButtonStyle.dart';
import 'package:comindors/Ui/Warna.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Listing/AccountItem.dart';
import '../Ui/StringData.dart';
import '../Ui/StyleText.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? outlet_id;
  ModelOutlet modelOutlet = ModelOutlet();

  List arraySts = ["Menunggu", "Diterimah", "Ditolak", "Selesai"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startLaunching();
  }

  _logOut(context) async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    getData.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false);
  }

  _checkData(String outlet_id) async {
    var data = await Provider.of<ApiOutlet>(context, listen: false)
        .outletLogin(id_outlet: outlet_id, setModel: true);

    if (data) {
      setState(() {
        modelOutlet =
            Provider.of<ApiOutlet>(context, listen: false).modelOutlet;
      });
    }
    return data;
  }

  startLaunching() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    String? dataOut = getData.getString(StringData.id_outlet);

    setState(() {
      outlet_id = dataOut;
    });
    _checkData(dataOut!);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        title: logo(25),
        actions: [
          InkWell(
            onTap: () {
              _logOut(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.logout_rounded,
                color: Warna.BiruPrimary,
              ),
            ),
          )
        ],

        // centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 190.0,
              margin: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Warna.BiruPrimary,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text("Hallo",
                      textAlign: TextAlign.start,
                      style: StyleText.textSubHeaderPutih20),
                  Text(modelOutlet.outletNama.toString(),
                      textAlign: TextAlign.start,
                      style: StyleText.textHeaderPutih24),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text("Lakukan transaksi dengan menekan tombol dibawah",
                      style: StyleText.textBiasaPutih12),
                  SizedBox(
                      width: double.infinity,
                      child: StyleButton.buttonPrimary(
                          context: context,
                          navigator: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TopupPage(
                                      idOutlet: outlet_id,
                                    )));
                          },
                          title: "Deposit / Topup",
                          colors: Colors.red)),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 349.0,
                  ),
                  margin: const EdgeInsets.only(top: 15.0),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("10 Transaksi Terakhir",
                                textAlign: TextAlign.start,
                                style: StyleText.textBodyHitam16),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        RiwayatPage(outlet: outlet_id)));
                              },
                              child: Text("Selengkapnya",
                                  textAlign: TextAlign.center,
                                  style: StyleText.textTebalHitam12
                                      .apply(color: Colors.red)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: FutureBuilder(
                            future:
                                Provider.of<ApiPayment>(context, listen: false)
                                    .riwayatList(
                                        outlet_id: outlet_id.toString(),
                                        status: arraySts),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Warna.BiruPrimary)),
                                );
                              } else {
                                return Consumer<ApiPayment>(
                                    builder: (ctx, listTransaksi, child) {
                                  // modelUser = dataUser.modelUser;
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          listTransaksi.listPayment.length >= 10
                                              ? 10
                                              : listTransaksi
                                                  .listPayment.length,
                                      itemBuilder: (context, index) {
                                        return accountItems(
                                            context: context,
                                            oddColour: index.floor().isEven
                                                ? Colors.grey.withOpacity(0.2)
                                                : Colors.white,
                                            modelPayment: listTransaksi
                                                .listPayment[index]);
                                      });
                                });
                              }
                            }),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
