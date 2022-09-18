import 'package:comindors/Ui/ButtonStyle.dart';
import 'package:comindors/Ui/StyleText.dart';
import 'package:comindors/Ui/Warna.dart';
import 'package:flutter/material.dart';

void dialogUi(BuildContext context,
    {String title = "",
    String desk = "",
    required var navigator,
    bool batal = true,
     String oke ="Oke"}) async {
  // show the loading dialog
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: (title.isEmpty) ? false : true,
                  child: Text(
                    title,
                    style: StyleText.textSubHeaderHitam20,
                  ),
                ),
                Visibility(
                  visible: (title.isEmpty) ? false : true,
                  child: const Divider(
                    color: Warna.BiruPrimary,
                  ),
                ),

                Text(desk,
                    style: StyleText.textBiasaHitam12.copyWith(fontSize: 16)),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: batal,
                      child: Expanded(
                        child: StyleButton.buttonPrimary(
                            context: context,
                            navigator: () {
                              return Navigator.pop(context);
                            },
                            title: "Batal", colors: Colors.red),
                      ),
                    ),
                    Visibility(
                      visible: batal,
                      child: const SizedBox(
                        width: 20,
                      ),
                    ),
                    Expanded(
                      child: StyleButton.buttonPrimary(
                          context: context, navigator: navigator, title: oke),
                    )
                  ],
                )
                // Some text
              ],
            ),
          ),
        );
      });
}
