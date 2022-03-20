import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../models/measurement.dart';
import 'list.dart';
import '../../../cubits/MeasuremetCubit/measurement_cubit.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late List<Measurement> allMeasurements;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MeasurementCubit>(context).get_measurements();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MeasurementCubit, MeasurementState>(
      builder: (context, state) {
        if (state is MeasurementLoaded) {
          allMeasurements = MeasurementCubit.get(context).measurements;
          print(allMeasurements);
          return MeasurmentsList(
            measurments: allMeasurements,
          );
        } else {
          return loading();
        }
      },
    );
  }

  Widget loading() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBlocWidget();
  }
}
