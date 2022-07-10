import 'package:final_pro/cubits/teams_cubit/teams_patient_cubit/teams_patient_cubit.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../measurements/components/expanded_container.dart';

class Item extends StatelessWidget {
  final Measurement measurement;
  final int i;

  const Item(this.measurement, this.i, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
              measurement.createdAt == null
                  ? measurement.fakeDate!
                  : measurement.createdAt!.substring(0, 10),
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.green.shade100,
            trailing: IconButton(
              icon: Icon(
                Icons.expand_more,
                color: Colors.green,
                size: 35,
              ),
              onPressed: () {
                BlocProvider.of<TeamsPatientCubit>(context).invertExpand(i);
              },
            ),
          ),
          BlocProvider.of<TeamsPatientCubit>(context).expanded.contains(i)
              ? ExpandedContainer(measurement)
              : Container(),
        ],
      ),
    );
  }

  getColor(int i) {
    var color;
    switch (i) {
      case 0:
        color = Colors.green;
        break;
      case 1:
        color = Colors.amber.shade500;
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
        text = 'The newest one';
        break;
      case 1:
      case 2:
      case 3:
      case 4:
        text = 'Recently measured ';
        break;
    }
    return text;
  }
}
