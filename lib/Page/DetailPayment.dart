import 'dart:io';

import 'package:comindors/Api/ApiPay.dart';
import 'package:comindors/Model/ModelDetailsPayment.dart';
import 'package:comindors/Page/DetailsFoto.dart';
import 'package:comindors/Ui/ButtonStyle.dart';
import 'package:comindors/Ui/ThreeRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Api/ApiRekening.dart';

import '../Dialog/DialogPayDetails.dart';
import '../Model/ModelPayment.dart';
import '../Ui/StyleText.dart';
import '../Ui/Warna.dart';

class DetailsPayment extends StatefulWidget {
  ModelPayment model;
  DetailsPayment({Key? key, required this.model}) : super(key: key);

  @override
  State<DetailsPayment> createState() => _DetailsPaymentState();
}

class _DetailsPaymentState extends State<DetailsPayment> {
  String namaRek = "";
  String typeRek = "";
  String nomorRek = "";
  String imageData = "";


  final formatter =
      NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0);

  Future<bool> getDataRekening() async {
    List dataRek = await ApiRekening().dataRekening();
    if (dataRek.isNotEmpty) {
      dataRek.map((value) {
        if (value.id.toString() == widget.model.idCmdRekening) {
          namaRek = value.namaRek!.toString();
          typeRek = value.tipeRek!.toString();
          nomorRek = value.noRek!.toString();
        }
      }).toList();
    }

    return true;
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        title: const Text(
          "DETAIL TRANSAKSI",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: getDataRekening(),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Warna.BiruPrimary)),
                    );
                  } else {
                    return Column(children: [
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Pembayaran",
                                    style: StyleText.textTebalHitam12
                                        .copyWith(color: Warna.BiruPrimary),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.model.payTotal
                                            .toString()
                                            .replaceAll("Rp", "Rp "),
                                        style: StyleText.textSubHeaderHitam20,
                                      ),
                                      Card(
                                        color: (widget.model.payStatus
                                                    .toString() ==
                                                "Selesai")
                                            ? Colors.green
                                            : (widget.model.payStatus
                                                        .toString() ==
                                                    "Diterimah")
                                                ? Colors.yellow
                                                : (widget.model.payStatus
                                                                .toString() ==
                                                            "Ditolak" ||
                                                        widget.model.payStatus
                                                                .toString() ==
                                                            "Batal")
                                                    ? Colors.red
                                                    : Colors.orange,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 10.0),
                                          child: Text(
                                            widget.model.payStatus
                                                .toString()
                                                .replaceAll("Rp", "Rp "),
                                            style: StyleText.textSubBodyPutih14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                          child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "Detail TopUp / Deposit",
                                style: StyleText.textBodyHitam16
                                    .copyWith(color: Warna.BiruPrimary),
                              ),
                              const Divider(),
                              ThreeRow(
                                title: "Penerimah",
                                value: namaRek,
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "Rekening",
                                value: typeRek,
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "No. Rek.",
                                value: nomorRek,
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              Divider(),
                              Text(
                                widget.model.id.toString(),
                                textAlign: TextAlign.start,
                                style: StyleText.textSubBodyHitam14
                                    .apply(color: Warna.BiruPrimary),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ThreeRow(
                                title: "Deposit",
                                value: widget.model.payDeposit.toString(),
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "Biaya Admin",
                                value: widget.model.payUnik.toString(),
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "Status",
                                value: widget.model.payStatus.toString(),
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "Tanggal",
                                value: widget.model.createdAt.toString(),
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              const Divider(),
                              ThreeRow(
                                title: "TOTAL",
                                value: widget.model.payTotal.toString(),
                                style: StyleText.textSubBodyHitam14
                                    .apply(color: Warna.BiruPrimary),
                                style2: StyleText.textSubBodyHitam14
                                    .apply(color: Warna.BiruPrimary),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (widget.model.detailsPay != null)
                        Card(
                            child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  " PENGIRIM ",
                                  style: StyleText.textBodyHitam16
                                      .copyWith(color: Warna.BiruPrimary),
                                ),
                                const Divider(),
                                ThreeRow(
                                  title: "Pengirim",
                                  value: widget.model.detailsPay!.payPengirim
                                      .toString()
                                      .toUpperCase(),
                                  style2: StyleText.textSubBodyHitam14,
                                ),
                                ThreeRow(
                                  title: "Rekening",
                                  value: widget.model.detailsPay!.payTipe
                                      .toString()
                                      .toUpperCase(),
                                  style2: StyleText.textSubBodyHitam14,
                                ),
                                ThreeRow(
                                  title: "No. Rek.",
                                  value: widget.model.detailsPay!.payRek
                                      .toString()
                                      .toUpperCase(),
                                  style2: StyleText.textSubBodyHitam14,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => DetailsFoto(
                                                payImg: widget
                                                    .model.detailsPay!.payImg
                                                    .toString())));
                                  },
                                  child: ThreeRow(
                                    title: "Foto",
                                    value: "Lihat Foto",
                                    style2: StyleText.textSubBodyHitam14
                                        .copyWith(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      if (widget.model.detailsPay == null)
                        SizedBox(
                          width: double.infinity,
                          child: StyleButton.buttonPrimary(
                              context: context,
                              navigator: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) {
                                      return TambahPayDetails(
                                          models: widget.model,
                                          update:(ModelDetailsPay model){
                                            setState(() {
                                              widget.model.detailsPay = model;
                                            });
                                          }

                                      );
                                    });
                              },
                              title: "Upload Bukti Transaksi"),
                        )
                    ]);
                  }
                })
          ],
        ),
      ),
    );
  }
}
