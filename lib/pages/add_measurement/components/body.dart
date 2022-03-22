import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../components/some_shared_components.dart';

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
                validate: (value) {
                  return '';
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Condition',
                type: TextInputType.text,
                controller: _conditionController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  return '';
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Pulse Rate',
                type: TextInputType.number,
                controller: _pulseController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  return '';
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Temperature',
                type: TextInputType.numberWithOptions(decimal: true),
                controller: _tempController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  return '';
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Pressure',
                type: TextInputType.number,
                controller: _pressureController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  return '';
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Respiration',
                type: TextInputType.text,
                controller: _respirationController,
              ),
              SizedBox(height: 20),
              defaultFormField(
                validate: (value) {
                  return '';
                },
                prefix: LineAwesomeIcons.ambulance,
                label: 'Weight',
                type: TextInputType.text,
                controller: _weightController,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
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
