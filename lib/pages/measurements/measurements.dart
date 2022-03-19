import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Measurements extends StatefulWidget {
  const Measurements({Key? key}) : super(key: key);
  static String routeName = "/measurements";

  @override
  State<Measurements> createState() => _MeasurementsState();

}

class _MeasurementsState extends State<Measurements> {
  late List<Measurement> all_measurements;

   @override
  void initState() {
    super.initState();
    BlocProvider.of<MeasurementCubit>(context).get_measurements();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measurements"),
      ),
      body: BlocBuilder<MeasurementCubit, MeasurementState>(
          builder: (context, state) {
        if (state is MeasurementLoaded) {
          all_measurements =MeasurementCubit.get(context).measurements;
          return Text(all_measurements[0].condition);
        } else {
          return Text("not recieved");
        }
      }),
    );
  }
}
