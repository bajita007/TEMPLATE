import 'package:comindors/Api/UrlData.dart';
import 'package:flutter/material.dart';

class DetailsFoto extends StatefulWidget {
  String payImg;
  DetailsFoto({Key? key, required this.payImg}) : super(key: key);

  @override
  State<DetailsFoto> createState() => _DetailsFotoState();
}

class _DetailsFotoState extends State<DetailsFoto> {
  @override
  Widget build(BuildContext context) {
    String url = DataUrl.homeUrl.replaceAll('api/', '');
    return Scaffold(
      appBar: AppBar(),
      body: Image.network(
        url + widget.payImg,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
