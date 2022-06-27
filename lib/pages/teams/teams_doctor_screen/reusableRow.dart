import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isLowPadding;
  const ReusableRow(
      {Key? key,
      required this.title,
      required this.value,
      this.isLowPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLowPadding
          ? EdgeInsets.fromLTRB(16, 8, 16, 0)
          : EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Muli',
                  fontWeight: FontWeight.w700),
              children: <TextSpan>[
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
