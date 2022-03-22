import 'package:flutter/material.dart';
import 'components/body.dart';

class AddMeasurements extends StatelessWidget {
  const AddMeasurements({Key? key}) : super(key: key);
  static String routeName = "/addMeasurements";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let\'s Add Yours Measurements'),
      ),
      body: Body(),
    );
  }
}
