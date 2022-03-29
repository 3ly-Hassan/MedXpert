import 'package:conditional_builder/conditional_builder.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../components/some_shared_components.dart';
import '../../../models/measurement.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  var _conditionController = TextEditingController();
  var _pulseController = TextEditingController();
  var _tempController = TextEditingController();
  var _sysController = TextEditingController();
  var _diaController = TextEditingController();
  var _respirationController = TextEditingController();
  var _weightController = TextEditingController();
  var _sugarController = TextEditingController();
  var _oxygenController = TextEditingController();
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
                  } else if ((value != '' &&
                      (int.parse(value!) < 27 || int.parse(value) > 220)))
                    return 'must be in (27:220)';
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
                  if (value != '' && int.tryParse(value!) is! int) {
                    return 'write a right value of your Oxygen';
                  } else if ((value != '' &&
                      (int.parse(value!) < 0 || int.parse(value) > 100)))
                    return 'must be in (0:100)';

                  return null;
                },
                onChange: (value) {},
                onSaved: (value) {},
                prefix: LineAwesomeIcons.heartbeat,
                label: 'Oxygen',
                type: TextInputType.number,
                controller: _oxygenController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  if (value != '' && num.tryParse(value!) is! num)
                    return 'write a right value of your Temp';
                  else if ((value != '' &&
                      (num.parse(value!) < 24.0 || num.parse(value) > 46.0)))
                    return 'must be in (24:46)';

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
                  if (value != '' && int.tryParse(value!) is! num)
                    return 'write a right value of your glucose';
                  else if (value != '' &&
                      (int.parse(value!) < 7 || int.parse(value) > 2656))
                    return 'must be in (7:2656)';
                  return null;
                },
                onSaved: (value) {},
                prefix: LineAwesomeIcons.low_temperature,
                label: 'Glucose',
                type: TextInputType.numberWithOptions(decimal: true),
                controller: _sugarController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: defaultFormField(
                      validate: (value) {
                        if (value != '' &&
                            (int.parse(value!) < 0 || int.parse(value) > 370))
                          return 'must be in (0:370)';
                        else if (value != '' && _diaController.text == '')
                          return 'Dia must be written';
                        return null;
                      },
                      onSaved: (value) {},
                      prefix: Icons.monitor_heart,
                      label: 'Sys Pressure',
                      type: TextInputType.number,
                      controller: _sysController,
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: defaultFormField(
                      validate: (value) {
                        if (value != '' &&
                            (int.parse(value!) < 0 || int.parse(value) > 370))
                          return 'must be in (0:370)';
                        else if (value != '' && _sysController.text == '')
                          return 'Sys must be written';

                        return null;
                      },
                      onSaved: (value) {},
                      prefix: Icons.monitor_heart,
                      label: 'DiaPressure',
                      type: TextInputType.number,
                      controller: _diaController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  if (value != '' && int.tryParse(value!) is! int)
                    return 'write a right value of your respiration';
                  if (value != '' &&
                      (int.parse(value!) < 0 || int.parse(value) > 80))
                    return 'must be in (0:80)';
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
              BlocConsumer<MeasurementCubit, MeasurementState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ConditionalBuilder(
                    condition: false,
                    builder: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    fallback: (context) => ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          Navigator.pop(context);
                          var m = Measurement(
                            fakeDate:
                                DateTime.now().toString().substring(0, 10),
                            condition: _conditionController.text,
                            temp: _tempController.text != ''
                                ? num.parse(_tempController.text)
                                : null,
                            systolicPressure: _sysController.text != ''
                                ? num.parse(_sysController.text)
                                : null,
                            diastolicPressure: _diaController.text != ''
                                ? num.parse(_diaController.text)
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
                            oxegen: _oxygenController.text != ''
                                ? num.parse(_oxygenController.text)
                                : null,
                            sugar: _sugarController.text != ''
                                ? num.parse(_sugarController.text)
                                : null,
                          );
                          print('the condition is ${m.condition}');
                          print('the temp is ${m.temp}');
                          print('the pulse is ${m.pulse}');
                          print('the respiration is ${m.respration}');
                          print('the weight is ${m.systolicPressure}');
                          print('the weight is ${m.diastolicPressure}');
                          print('the weight is ${m.sugar}');
                          print('the weight is ${m.oxegen}');
                          print('the weight is ${m.weight}');
                          MeasurementCubit.get(context).createMeasurement(m);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
