import 'package:flutter/material.dart';

class BuildTextContainer extends StatelessWidget {
  final constant;
  final text;
  const BuildTextContainer(this.constant, this.text, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            '$constant : $text',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.white,
        )
      ],
    );
  }
}
