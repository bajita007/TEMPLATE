import 'package:comindors/Api/ApiPayAdmin.dart';
import 'package:comindors/Model/ModelOutlet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Api/ApiRekening.dart';
import '../Model/ModelPayment.dart';
import '../Page/DetailsFoto.dart';
import '../Ui/ButtonStyle.dart';
import '../Ui/StyleText.dart';
import '../Ui/ThreeRow.dart';
import '../Ui/Warna.dart';

class DetailsTrxAdmin extends StatefulWidget {
  ModelPayment model;
  DetailsTrxAdmin({Key? key, required this.model}) : super(key: key);

  @override
  State<DetailsTrxAdmin> createState() => _DetailsTrxAdminState();
}

class _DetailsTrxAdminState extends State<DetailsTrxAdmin> {
  String namaRek = "";
  String typeRek = "";
  String nomorRek = "";
  late ModelOutlet modelOutlet;

  final formatter =
      NumberFormat.simpleCurrency(locale: "id_ID", decimalDigits: 0);

  Future<bool> getDataRekening() async {
    List dataRek = await ApiRekening().dataRekening();
    if (dataRek.isNotEmpty) {
      dataRek.map((value) {
        if (value.id.toString()  == widget.model.idCmdRekening) {
          namaRek = value.namaRek!.toString();
          typeRek = value.tipeRek!.toString();
          nomorRek = value.noRek!.toString();
        }
      }).toList();
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    // modelOutlet = widget?.model.outletId;
    print("${widget.model.outlet?.outletNama}KONTOLSS");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
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
                initialData: [],
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
                              const Divider(),
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
                      Card(
                          child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                " Outlet & Pengirim ",
                                style: StyleText.textBodyHitam16
                                    .copyWith(color: Warna.BiruPrimary),
                              ),
                              const Divider(),
                              ThreeRow(
                                title: "Outlet",
                                value:
                                    widget.model.outlet?.outletNama.toString(),
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "ID Outlet",
                                value: widget.model.outlet?.outletId.toString(),
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              ThreeRow(
                                title: "Lokasi",
                                value:
                                    "${widget.model.outlet?.kabupaten} \n${widget.model.outlet?.kecamatan}",
                                style2: StyleText.textSubBodyHitam14,
                              ),
                              const Divider(),
                              if(widget.model.detailsPay != null)
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      (widget.model.payStatus == "Menunggu")
                          ? Row(
                              children: [
                                Expanded(
                                  child: StyleButton.buttonPrimary(
                                      context: context,
                                      navigator: () {
                                        _statusPay(context, 'Diterimah', widget.model);
                                      },
                                      title: "Diterimah",
                                      colors: Colors.yellowAccent),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: StyleButton.buttonPrimary(
                                      context: context,
                                      navigator: () {
                                        _statusPay(context, 'Ditolak', widget.model);
                                      },
                                      title: "Tolak",
                                      colors: Colors.red),
                                ),
                              ],
                            )
                          : Visibility(
                              visible: (widget.model.payStatus == "Selesai" ||
                                      widget.model.payStatus == "Ditolak")
                                  ? false
                                  : true,
                              child: SizedBox(
                                width: double.infinity,
                                child: StyleButton.buttonPrimary(
                                    context: context,
                                    navigator: () {
                                      _statusPay(context, 'Selesai', widget.model);
                                    },
                                    title: "Selesai",
                                    colors: Colors.green),
                              ),
                            ),
                    ]);
                  }
                })
          ],
        ),
      ),
    );
  }
}

void _statusPay(BuildContext context, String s, ModelPayment model) {
  model.payStatus =s;
  Provider.of<ApiPayAdmin>(context, listen: false)
      .updateAdminPay(modelPay: model)
      .then((data) {
    final scaffold = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    if (data) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text("Berhasil Perbaruhi Transaksi..."),
          duration: Duration(seconds: 3),
        ),
      );
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } else {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text("Gagal tambah Bank..."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  });
}
