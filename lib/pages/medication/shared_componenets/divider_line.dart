import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: Theme.of(context).primaryColor,
    );
  }
}
