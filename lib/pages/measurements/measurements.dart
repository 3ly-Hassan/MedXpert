import 'package:conditional_builder/conditional_builder.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../constants.dart';
import '../add_measurement/addMeasurements.dart';
import 'components/EmptyMeasurements.dart';
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
        backgroundColor: kAppBarColor,
      ),
      body: BlocConsumer<MeasurementCubit, MeasurementState>(
        listener: (context, state) {},
        builder: (context, state) => MeasurementCubit.get(context).empty
            ? EmptyMeasurements()
            : ConditionalBuilder(
                condition:
                    MeasurementCubit.get(context).measurements.length > 0,
                builder: (builder) => Body(
                  len: MeasurementCubit.get(context).measurements.length,
                  measurements: MeasurementCubit.get(context).measurements,
                  expanded: MeasurementCubit.get(context).expanded,
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddMeasurements.routeName);
        },
        backgroundColor: kAppBarColor,
        child: Icon(LineAwesomeIcons.plus),
      ),
    );
  }
}
