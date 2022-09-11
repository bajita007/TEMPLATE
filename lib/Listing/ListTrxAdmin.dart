import 'dart:math';

import 'package:comindors/Model/ModelPayment.dart';
import 'package:comindors/Ui/Warna.dart';
import 'package:flutter/material.dart';

import '../Admin/DetailsTrxAdmin.dart';
import '../Page/DetailPayment.dart';

GestureDetector ListTrxAdmin(
    {required BuildContext context,
    required ModelPayment modelPayment,
    Color oddColour = Colors.white}) {
  // var finalId = int.parse(id_pay) + Random().nextInt(90);
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => DetailsTrxAdmin(model: modelPayment)),
      );
    },
    child: Container(
      decoration: BoxDecoration(color: oddColour),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(modelPayment.payStatus.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (modelPayment.payStatus.toString() == "Selesai")
                          ? Colors.green
                          : (modelPayment.payStatus.toString() == "Diterimah")
                              ? Colors.yellow
                              : (modelPayment.payStatus.toString() ==
                                          "Ditolak" ||
                                      modelPayment.payStatus.toString() ==
                                          "Batal")
                                  ? Colors.red
                                  : Colors.orange,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold)),
              Text(
                modelPayment.createdAt.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(modelPayment.outlet!.outletNama.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold)),
              Text(modelPayment.payTotal.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("ID ${modelPayment.outlet!.outletId}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Warna.BiruPrimary)),
              Text(modelPayment.id.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Warna.BiruPrimary)),
            ],
          ),
        ],
      ),
    ),
  );
}
