import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import 'components/body.dart';


class Measurements extends StatefulWidget {
  const Measurements({Key? key}) : super(key: key);
  static String routeName = "/measurements";

  @override
  State<Measurements> createState() => _MeasurementsState();

}

class _MeasurementsState extends State<Measurements> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measurements"),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
