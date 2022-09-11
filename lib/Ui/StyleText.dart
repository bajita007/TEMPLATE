
import 'package:flutter/material.dart';

import 'Warna.dart';

abstract class StyleText {
  static const textTebalPutih12 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: Warna.Bg,
  );
  static const textTebalHitam12 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: Warna.Hitam,
  );

  static const textBiasaPutih12 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Warna.Bg,
  );

  static const textBiasaHitam12 = const TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Warna.Hitam,
  );
  static const textBodyHitam16 = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Warna.Hitam,
  );
  static const textBodyPutih16 = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w800,
    color: Warna.Bg,
  );

  static const textSubBodyHitam14 = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Warna.Hitam,
  );
  static const textSubBodyPutih14 = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w800,
    color: Warna.Bg,
  );
  static const textSubHeaderPutih20 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    color: Warna.Bg,
  );
  static const textSubHeaderHitam20 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Warna.Hitam,
  );

  static const textHeaderHitam24 = const TextStyle(
    fontSize: 24.0,
    color: Warna.Hitam,
    fontWeight: FontWeight.w800,
  );
  static const textHeaderPutih24 = const TextStyle(
    fontSize: 24.0,
    color: Warna.Bg,
    fontWeight: FontWeight.w800,
  );
  static const textKecilHitam10 = const TextStyle(
    fontSize: 10.0,
    color: Warna.Hitam,
    fontWeight: FontWeight.w600,
  );


}
Image logo(double ukuran) {
  return Image.asset(
    "assets/icons/logo.jpg",
    height: ukuran,
    fit: BoxFit.fitWidth,
  );
}


