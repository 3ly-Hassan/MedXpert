import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../models/measurement.dart';
import '../../../cubits/MeasuremetCubit/measurement_cubit.dart';

class Body extends StatelessWidget {
  final len;
  final measurements;
  final expanded;

  const Body({Key? key, this.len, this.measurements, this.expanded})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return item(measurements[index], index, context);
      },
      itemCount: len,
    );
  }

  Widget item(Measurement measurement, int i, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              getText(i),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            subtitle: Text(
              measurement.createdAt.substring(0, 10),
              style: TextStyle(color: Colors.amber),
            ),
            tileColor: getColor(i),
            trailing: IconButton(
              icon: Icon(
                Icons.expand_more,
                color: Colors.amber,
                size: 35,
              ),
              onPressed: () {
                MeasurementCubit.get(context).invertExpand(i);
              },
            ),
          ),
          expanded.contains(i) ? expandedContainer(measurement) : Container(),
        ],
      ),
    );
  }

  getColor(int i) {
    var color;
    switch (i) {
      case 0:
        color = Colors.green.shade700;
        break;
      case 1:
        color = Colors.green.shade500;
        break;
      case 2:
        color = Colors.green.shade300;
        break;
      case 3:
        color = Colors.green.shade200;
        break;
      case 4:
        color = Colors.green.shade100;
        break;
    }
    return color;
  }

  getText(int i) {
    var text;
    switch (i) {
      case 0:
        text = 'The Newest One';
        break;
      case 1:
      case 2:
      case 3:
      case 4:
        text = 'recently measured ';
        break;
    }
    return text;
  }

  Widget expandedContainer(Measurement m) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          buildTextContainer('The Condition', m.condition),
          buildTextContainer('The Blood Pressure', m.pressure),
          buildTextContainer('The Pulse Rate', m.pulse),
          buildTextContainer('The Respiration', m.respration),
          buildTextContainer('The Temperature', m.temp),
          buildTextContainer('The Weight', m.weight),
        ],
      ),
    );
  }

  buildTextContainer(constant, text) {
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
