import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: kPrimaryColor,
          onPressed: press as void Function()?,
          child: Text(
            text!,
            style: TextStyle(
              fontSize: (18),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
