import 'package:comindors/Ui/StyleText.dart';
import 'package:flutter/material.dart';


import 'Warna.dart';

class StyleButton {
  static ElevatedButton buttonPrimary(
      {required BuildContext context,required var navigator,required String title, Color colors = Warna.BiruPrimary}) {
    return ElevatedButton(
      onPressed: navigator,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: colors,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 11.0),
        textStyle: StyleText.textSubBodyPutih14.copyWith(
          fontFamily: 'QuickSand',
        ),
      ),
      child: Text(
        title,
      ),
    );
  }

}
