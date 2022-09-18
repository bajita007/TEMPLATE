import 'package:comindors/Api/ApiRekening.dart';
import 'package:comindors/Model/ModekRek.dart';
import 'package:comindors/Dialog/LoadingUi.dart';
import 'package:comindors/Ui/StyleText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../Ui/ButtonStyle.dart';
import '../Ui/StyleForm.dart';
import '../Ui/Warna.dart';

void TambahBank(
    {required BuildContext context,
    required navigator,
    required GlobalKey<FormBuilderState> formKey,
    required TextEditingController cnama,
    required TextEditingController ctipe,
    required String sts,
    required TextEditingController norek,
    String title = "Tambah Bank"}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: StyleText.textSubHeaderHitam20
                          .copyWith(color: Warna.BiruPrimary),
                    ),
                    const Divider(
                      color: Warna.BiruPrimary,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FormBuilder(
                              key: formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  FormBuilderTextField(
                                    name: 'Nama Pemilik Rekening',
                                    controller: cnama,
                                    decoration: StyleForm.borderInputStyle(
                                        title: "Nama",
                                        prefix: const Icon(
                                          Icons.person,
                                          color: Warna.BiruPrimary,
                                        )),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 10),
                                  FormBuilderTextField(
                                    name: 'No Rek',
                                    controller: norek,
                                    decoration: StyleForm.borderInputStyle(
                                        title: "No Rekening",
                                        prefix: const Icon(
                                          Icons.numbers,
                                          color: Warna.BiruPrimary,
                                        )),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.numeric(),
                                    ]),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 10),
                                  FormBuilderTextField(
                                    name: 'Tipe Rekening',
                                    controller: ctipe,
                                    decoration: StyleForm.borderInputStyle(
                                        title: "Tipe Rekening",
                                        prefix: const Icon(
                                          Icons.food_bank,
                                          color: Warna.BiruPrimary,
                                        )),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  // const SizedBox(height: 10),
                                  // FormBuilderCheckbox(
                                  //   name: 'accept_terms',
                                  //   initialValue:
                                  //       (sts.contains('aktif')) ? true : false,
                                  //   onChanged: (value) {
                                  //     sts = value.toString();
                                  //   },
                                  //   title: const Text(
                                  //     "Status Bank",
                                  //     style: StyleText.textBodyHitam16,
                                  //   ),
                                  //   decoration: StyleForm.borderInputStyle(
                                  //       title: 'Status bank', prefix: null),
                                  // ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: StyleButton.buttonPrimary(
                                            context: context,
                                            navigator: () {
                                              Navigator.pop(context);
                                            },
                                            title: "Batal",
                                            colors: Colors.red),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: StyleButton.buttonPrimary(
                                            context: context,
                                            navigator: () {
                                              loadingUi(context);
                                              formKey.currentState?.save();
                                              if (formKey.currentState
                                                      ?.validate() ==
                                                  true) {
                                                simpanData(sts, cnama, norek,
                                                    ctipe, context, formKey);
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            },
                                            title: "Simpan"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                // Some text
                ));
      });
}

void simpanData(
    String sts,
    TextEditingController cnama,
    TextEditingController norek,
    TextEditingController ctipe,
    BuildContext context,
    GlobalKey<FormBuilderState> formKey) {
  Provider.of<ApiRekening>(context, listen: false)
      .tambahRek(
          modelRekening: ModelRekening(
              tipeRek: ctipe.text.toString(),
              noRek: norek.text.toString(),
              namaRek: cnama.text.toString(),
              statusRek: "Aktif")
          // statusRek:
          //     (sts.toString() == "false" || sts.toString() == "Aktif")
          //         ? 'Tidak Aktif'
          //         : 'Aktif')
          )
      .then((data) {
    final scaffold = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    if (data.id != null) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text("Berhasil tambah bank..."),
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
