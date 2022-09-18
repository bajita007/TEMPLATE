import 'package:flutter/material.dart';

class ThreeRow extends StatelessWidget {
  String? title, value;
  TextStyle? style;
  TextStyle? style2;
  ThreeRow({Key? key, this.title, this.value, this.style, this.style2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                title! ?? "",
                style: style,
                textAlign: TextAlign.start,
              )),
          const SizedBox(width: 8, child: Text(":")),
          Expanded(
              flex: 5,
              child: Text(
                value! ?? "",
                textAlign: TextAlign.start,
                style: style2,
              ))
        ],
      ),
    );
  }
}
