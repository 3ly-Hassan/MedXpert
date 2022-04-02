import 'package:flutter/material.dart';

import '../constants.dart';

class LoadingRow extends StatelessWidget {
  const LoadingRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(kLoading),
        CircularProgressIndicator(),
      ],
    );
  }
}
