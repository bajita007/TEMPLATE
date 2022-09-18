import 'dart:io';

import 'package:comindors/Model/ModelDetailsPayment.dart';
import 'package:comindors/Model/ModelPayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Api/ApiPayDetails.dart';
import '../Ui/ButtonStyle.dart';
import '../Ui/StyleForm.dart';
import '../Ui/StyleText.dart';
import '../Ui/Warna.dart';
import 'LoadingUi.dart';

class TambahPayDetails extends StatefulWidget {
  ModelPayment models;
  Null Function(ModelDetailsPay model) update;
  TambahPayDetails({Key? key, required this.models, required this.update})
      : super(key: key);

  @override
  State<TambahPayDetails> createState() => _TambahPayDetailsState();
}

class _TambahPayDetailsState extends State<TambahPayDetails> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  File? image;
  bool showText = false;
  ModelDetailsPay? modelDetailsPay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  pickImage() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      final imageTemp = File(images.path);
      setState(() {
        image = imageTemp;
        showText = false;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Upload Bukti Transaksi",
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
                                name: 'nama',
                                // controller: cnama,
                                decoration: StyleForm.borderInputStyle(
                                        title: "Pengirim",
                                        prefix: const Icon(
                                          Icons.person,
                                          color: Warna.BiruPrimary,
                                        ))
                                    .copyWith(
                                        fillColor:
                                            Colors.grey.withOpacity(0.3)),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'norek',
                                // controller: norek,
                                decoration: StyleForm.borderInputStyle(
                                        title: "No Rekening",
                                        prefix: const Icon(
                                          Icons.numbers,
                                          color: Warna.BiruPrimary,
                                        ))
                                    .copyWith(
                                        fillColor:
                                            Colors.grey.withOpacity(0.3)),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                ]),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'TipeRek',
                                // controller: ctipe,
                                decoration: StyleForm.borderInputStyle(
                                        title: "Tipe Rekening",
                                        prefix: const Icon(
                                          Icons.food_bank,
                                          color: Warna.BiruPrimary,
                                        ))
                                    .copyWith(
                                        fillColor:
                                            Colors.grey.withOpacity(0.3)),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 10),
                              if (image != null)
                                Visibility(
                                    visible: (image != null) ? true : false,
                                    child: Image.file(
                                      image!,
                                      height: 150,
                                    )),
                              SizedBox(
                                width: double.infinity,
                                child: StyleButton.buttonPrimary(
                                    context: context,
                                    navigator: () async {
                                      await pickImage();
                                    },
                                    title: "Pilih Gambar"),
                              ),
                              Visibility(
                                visible: showText,
                                child: Text(
                                  'Gambar tidak boleh kosong',
                                  style: StyleText.textBiasaPutih12
                                      .apply(color: Colors.red),
                                ),
                              ),
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
                                                  true &&
                                              image != null) {
                                            String pengirim = formKey
                                                .currentState?.value['nama'];
                                            String norek = formKey
                                                .currentState?.value['norek'];
                                            String tiperek = formKey
                                                .currentState?.value['TipeRek'];
                                            simpanData(
                                                context,
                                                formKey,
                                                widget.models,
                                                image!,
                                                pengirim,
                                                norek,
                                                tiperek,
                                                widget.update);
                                          } else {
                                            setState(() {
                                              showText = true;
                                            });
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
            )));
  }

  void simpanData(
      BuildContext context,
      GlobalKey<FormBuilderState> formKey,
      ModelPayment models,
      File image,
      String pengirim,
      String norek,
      String tiperek,
      Null Function(ModelDetailsPay model) update) {
    String dataId = models.id.toString().substring(14);

    Provider.of<ApiPayDetails>(context, listen: false)
        .addPayDetails(
            modelPay: ModelDetailsPay(
                payPengirim: pengirim,
                payRek: norek,
                payId: int.parse(dataId).toString(),
                payTipe: tiperek,
                outletId: models.outletId),
            file: image)
        .then((data) {
      final scaffold = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      if (data.id != null) {
        update(data);

        scaffold.showSnackBar(
          const SnackBar(
            content: Text("Berhasil tambah bukti transaksi..."),
            duration: Duration(seconds: 3),
          ),
        );
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      } else {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text("Gagal tambah bukti transaksi..."),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }
}
