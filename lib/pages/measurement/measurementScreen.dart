import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => measurementItem(index)),
    );
  }

  measurementItem(index, {Measurement? measurement}) {
    return Column(children: [
      ListTile(),
      Divider(
        height: 1,
        color: Colors.deepPurple,
      ),
    ]);
  }
}
