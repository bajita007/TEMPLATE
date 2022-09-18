import 'package:flutter/material.dart';

import 'Warna.dart';

class StyleForm {
  static InputDecoration borderInputStyle(
      {required String title, required var prefix}) {
    // Widget prefix = prefix ?? Icon(Icons.import_contacts_sharp);

    // Widget dataPrefix =

    return InputDecoration(
        labelText: title,
        filled: true,
        // fillColor: Colors.white,
        focusColor: Warna.BiruPrimary,
        prefixStyle: const TextStyle(
          color: Warna.BiruPrimary,
        ),
        focusedBorder: borderBiruForm,
        disabledBorder: borderBiruForm,
        enabledBorder: borderPutihForm,
        errorBorder: borderMerahForm,
        border: borderBiruForm,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        labelStyle: const TextStyle(
          color: Warna.BiruPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        prefixIcon: prefix,
        prefixIconColor: Warna.BiruPrimary,
        errorStyle: const TextStyle(
          color: Colors.red,
        ));
  }

  static const borderBiruForm = OutlineInputBorder(
      borderSide: BorderSide(color: Warna.BiruPrimary),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ));

  static const borderPutihForm = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ));

  static const borderMerahForm = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ));
}
