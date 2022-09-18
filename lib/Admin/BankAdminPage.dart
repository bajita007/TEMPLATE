import 'package:comindors/Api/ApiRekening.dart';
import 'package:comindors/Listing/ListBankAdmin.dart';
import 'package:comindors/Dialog/DialogTambahBank.dart';
import 'package:comindors/Ui/StyleText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../Model/ModekRek.dart';
import '../Ui/ButtonStyle.dart';
import '../Ui/Warna.dart';

class BankAdminPage extends StatefulWidget {
  const BankAdminPage({Key? key}) : super(key: key);

  @override
  State<BankAdminPage> createState() => _BankAdminPageState();
}

class _BankAdminPageState extends State<BankAdminPage> {
  List<ModelRekening> _listRek = [];
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _firstLoad();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Bank",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        floatingActionButton: StyleButton.buttonPrimary(
            context: context,
            navigator: () {
              TextEditingController _nama_controler =
                  TextEditingController(text: '');
              TextEditingController _tipe_controler =
                  TextEditingController(text: '');

              TextEditingController _noRek_controler =
                  TextEditingController(text: '');
              TambahBank(
                  context: context,
                  navigator: () {},
                  formKey: _formKey,
                  cnama: _nama_controler,
                  ctipe: _tipe_controler,
                  sts: "Aktif",
                  norek: _noRek_controler);
            },
            title: "Tambah Bank",
            colors: Colors.blue),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder(
            future: Provider.of<ApiRekening>(context, listen: false)
                .dataRekening(status: 'admin'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Warna.BiruPrimary)),
                );
              } else {
                return Consumer<ApiRekening>(builder: (ctx, rekening, child) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                          itemCount: rekening.listRekening.length,
                          itemBuilder: (_, index) => listBank(
                                context: context,
                                model: rekening.listRekening[index],
                              )));
                });
              }
            }));
  }
}
