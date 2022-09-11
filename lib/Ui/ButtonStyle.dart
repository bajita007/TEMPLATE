import 'package:comindors/Ui/StyleText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'Warna.dart';

class StyleButton {
  static ElevatedButton buttonPrimary(
      {required BuildContext context,required var navigator,required String title}) {
    return ElevatedButton(
      onPressed: navigator,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Warna.BiruPrimary,
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

  // static ElevatedButton.styleFrom buttonBlue(){
  //  return ElevatedButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       primary: const Color(0xff1b4dff),
  //       padding: const EdgeInsets.symmetric(
  //           horizontal: 15.0, vertical: 11.0),
  //       textStyle: const TextStyle(
  //           fontSize: 30, fontWeight: FontWeight.bold))
  // }
}
