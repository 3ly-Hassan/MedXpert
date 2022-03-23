import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../components/some_shared_components.dart';
import '../../../models/measurement.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  var _conditionController = TextEditingController();
  var _pulseController = TextEditingController();
  var _tempController = TextEditingController();
  var _pressureController = TextEditingController();
  var _respirationController = TextEditingController();
  var _weightController = TextEditingController();
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              defaultFormField(
                onSaved: (value) {},
                onChange: (value) {},
                validate: (value) {
                  if (value!.isEmpty) return 'you must write the condition';
                  return null;
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Condition',
                type: TextInputType.text,
                controller: _conditionController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  if (value != '' && int.tryParse(value!) is! int) {
                    return 'write a right value of your PR';
                  }
                  return null;
                },
                onChange: (value) {},
                onSaved: (value) {},
                prefix: LineAwesomeIcons.heartbeat,
                label: 'Pulse Rate',
                type: TextInputType.number,
                controller: _pulseController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  if (value != '' && int.tryParse(value!) is! num)
                    return 'write a right value of your Temp';
                  return null;
                },
                onSaved: (value) {},
                prefix: LineAwesomeIcons.low_temperature,
                label: 'Temperature',
                type: TextInputType.numberWithOptions(decimal: true),
                controller: _tempController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  return null;
                },
                onSaved: (value) {},
                prefix: Icons.monitor_heart,
                label: 'Pressure',
                type: TextInputType.number,
                controller: _pressureController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  if (value != '' && int.tryParse(value!) is! int)
                    return 'write a right value of your respiration';
                  return null;
                },
                onSaved: (value) {},
                prefix: LineAwesomeIcons.airbnb,
                label: 'Respiration',
                type: TextInputType.number,
                controller: _respirationController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  if (value != '' && int.tryParse(value!) is! num)
                    return 'write a right value of your weight';
                  return null;
                },
                onSaved: (value) {},
                prefix: LineAwesomeIcons.weight,
                label: 'Weight',
                type: TextInputType.numberWithOptions(decimal: true),
                controller: _weightController,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(context);
                    _key.currentState!.save();
                    var m = Measurement(
                      condition: null,
                      temp: _tempController.text != ''
                          ? num.parse(_tempController.text)
                          : null,
                      pressure: _pressureController.text != ''
                          ? _pressureController.text
                          : null,
                      pulse: _pulseController.text != ''
                          ? int.parse(_pulseController.text)
                          : null,
                      respration: _respirationController.text != ''
                          ? int.parse(_respirationController.text)
                          : null,
                      weight: _weightController.text != ''
                          ? num.parse(_weightController.text)
                          : null,
                    );
                    print('the condition is ${m.condition}');
                    print('the temp is ${m.temp}');
                    print('the pulse is ${m.pulse}');
                    print('the pressure is ${m.pressure}');
                    print('the respiration is ${m.respration}');
                    print('the weight is ${m.weight}');
                    MeasurementCubit.get(context).createMeasurement(m);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent,
                  fixedSize: const Size(160, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
