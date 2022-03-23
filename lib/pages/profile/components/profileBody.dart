import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = MeasurementCubit.get(context);

    return cubit.patient.username != null
        ? SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset('assets/images/profile.png'),
                  ),
                  Text(cubit.patient.username!)
                ],
              ),
            ),
          )
        : Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(fontSize: 26),
            ),
          );
  }
}
