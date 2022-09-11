import 'dart:math';

import 'package:comindors/Api/ApiPay.dart';
import 'package:comindors/Api/ApiRekening.dart';
import 'package:comindors/Model/ModelPayment.dart';
import 'package:comindors/Page/DetailPayment.dart';
import 'package:comindors/Ui/ThreeRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ModekRek.dart';
import '../Ui/ButtonStyle.dart';
import '../Ui/FormatRupiah.dart';
import '../Ui/LoadingUi.dart';
import '../Ui/StringData.dart';
import '../Ui/StyleForm.dart';
import '../Ui/StyleText.dart';
import '../Ui/Warna.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TopupPage extends StatefulWidget {
  String? idOutlet;
  TopupPage({Key? key, this.idOutlet}) : super(key: key);

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  int _adminRandom = 0;
  late String namaRek;
  String nomorRek = "";
  String depo = "";
  String typeRek = "";
  int deposit = 0;
  List<ModelRekening> dataRek = [];
  bool buttonNext = false;
  // var outlet_id;
  // late Future _getAllrek;

  // void _onChanged(dynamic val) => debugPrint(val.toString());
  final formatter =
      NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    randomBiaya();
    namaRek = "";
  }

  Future<List<ModelRekening>> getDataRekening() async {
    dataRek = await ApiRekening().dataRekening();
    if (dataRek.isNotEmpty && nomorRek.isEmpty) {
      dataRek.map((value) {
        if (value.id.toString() == "1") {
          namaRek = value.namaRek!.toString();
          typeRek = value.tipeRek!.toString();
          nomorRek = value.noRek!.toString();
        }
      }).toList();
    }

    return dataRek;
  }

  randomBiaya() {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    setState(() {
      _adminRandom = randomNumber + 2000;
    });
    // return _adminRandom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.grey,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Top Up Saldo",
          textAlign: TextAlign.center,
        ),
        // centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(25.0),
            decoration:  BoxDecoration(
              color: Warna.BiruPrimary.withOpacity(0.90),
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Limit harian Anda tersisa : ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Rp. 3.000.000',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Maks. saldo untuk di top up sebesar : ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: 'Rp. 3.000.000',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Setiap transaksi dikenakan biaya sebesar +',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontStyle: FontStyle.italic),
                      ),
                      TextSpan(
                        text: 'Rp. 2000',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: getDataRekening(),
                  initialData: [],
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Warna.BiruPrimary)),
                      );
                    } else {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Top Up Salado",
                                  style: StyleText.textBodyHitam16,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                FormBuilder(
                                    key: _formKey,
                                    // enabled: false,

                                    autovalidateMode: AutovalidateMode.disabled,
                                    initialValue: const {
                                      'deposit': 'Rp0',
                                    },
                                    skipDisabled: true,
                                    child: Column(
                                      children: [
                                        FormBuilderTextField(
                                          autovalidateMode:
                                              AutovalidateMode.always,
                                          name: 'deposit',
                                          decoration:
                                              StyleForm.borderInputStyle(
                                                  title: "TOTAL DEPOSIT",
                                                  prefix: null),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                          ]),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CurrencyInputFormatter()
                                          ],
                                          onChanged: (value) {
                                            String finaldata = value
                                                .toString()
                                                .replaceAll(".", "");
                                            finaldata = finaldata
                                                .toString()
                                                .replaceAll("Rp", "");
                                            setState(() {
                                              deposit = int.parse(finaldata);
                                              if (int.parse(finaldata) >=
                                                  2000) {
                                                buttonNext = true;
                                              } else {
                                                buttonNext = false;
                                              }
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        FormBuilderRadioGroup(
                                          initialValue: 1,
                                          decoration:
                                              StyleForm.borderInputStyle(
                                                  title: "Pembayaran",
                                                  prefix: null),
                                          name: 'pembayaran',
                                          onChanged: (string) {
                                            dataRek.map((value) {
                                              if (value.id == string) {
                                                setState(() {
                                                  namaRek =
                                                      value.namaRek!.toString();
                                                  typeRek = value.tipeRek!;
                                                  nomorRek = value.noRek!;
                                                });
                                              }
                                            }).toList();
                                          },
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required()
                                          ]),
                                          options: dataRek
                                              .map((number) =>
                                                  FormBuilderFieldOption(
                                                      value: number.id,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                                "( ${number.tipeRek} ) ${number.noRek} ",
                                                                style: StyleText
                                                                    .textSubBodyHitam14),
                                                          ),
                                                          Text(
                                                            number.namaRek
                                                                .toString(),
                                                            style: StyleText
                                                                .textBiasaHitam12,
                                                          ),
                                                        ],
                                                      )))
                                              .toList(),
                                        ),
                                        const SizedBox(height: 5),
                                        const Divider(),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "Details Transaksi",
                                          style: StyleText.textBodyHitam16,
                                        ),
                                        const SizedBox(height: 5),
                                        ThreeRow(
                                            title: "Total Deposit",
                                            value: formatter.format(deposit)),
                                        ThreeRow(
                                            title: "Nama Rek.", value: namaRek),
                                        ThreeRow(
                                            title: "Ke Rek.", value: typeRek),
                                        ThreeRow(
                                            title: "No Re.", value: nomorRek),
                                        ThreeRow(
                                            title: "Total Biaya",
                                            value: formatter.format(
                                                _adminRandom + deposit)),
                                        const SizedBox(height: 5),
                                        const Divider(),
                                        const SizedBox(height: 5),
                                        Visibility(
                                          visible: buttonNext,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: StyleButton.buttonPrimary(
                                                context: context,
                                                navigator: () {
                                                  _formKey.currentState?.save();
                                                  String? dataNoRek = _formKey
                                                      .currentState
                                                      ?.value["pembayaran"]
                                                      .toString();

                                                  // print(idRek +"OKEE");
                                                  ModelPayment modelPay =
                                                      ModelPayment(
                                                    outletId: widget.idOutlet,
                                                    payStatus: "Menunggu",
                                                    payDeposit:
                                                        deposit.toString(),
                                                    payTotal:
                                                        (deposit + _adminRandom)
                                                            .toString(),
                                                    payUnik:
                                                        _adminRandom.toString(),
                                                    idCmdRekening: dataNoRek,
                                                  );
                                                  fetchData(context);
                                                  _saveData(modelPay);
                                                },
                                                title: "Selanjutnya"),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  })),
        ],
      ),
    );
  }

  _saveData(ModelPayment modelPay) {
    Provider.of<ApiPayment>(context, listen: false)
        .savePayment(modelPay: modelPay)
        .then((data) {
      final scaffold = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();

      if (data.id != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DetailsPayment(model: data)),
        );
      } else {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text("Deposi saldo gagal di lakukan..."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }
}
