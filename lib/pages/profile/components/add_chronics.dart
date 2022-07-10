import 'dart:math';

import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddChronics extends StatelessWidget {
  AddChronics({Key? key}) : super(key: key);
  static String routeName = "/addChronics";
  var nameController = TextEditingController();
  var sinceController = TextEditingController();
  var stateController = TextEditingController();
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Add to your Chronics'),
        actions: [
          IconButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  var model = Chronics();
                  model.chronicName = nameController.text;
                  model.since = sinceController.text;
                  model.state = stateController.text;
                  MeasurementCubit.get(context).addToList(model);

                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.save, color: Colors.white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              defaultFormField(
                  controller: nameController,
                  type: TextInputType.text,
                  validate: (validate) {
                    if (nameController.text.isEmpty) return 'is required';
                    return null;
                  },
                  label: 'Name',
                  prefix: LineAwesomeIcons.address_book),
              SizedBox(height: 20),
              // defaultFormField(
              //     controller: sinceController,
              //     type: TextInputType.number,
              //     validate: (validate) {
              //       if (sinceController.text.isEmpty) return 'is required';
              //       return null;
              //     },
              //     label: 'Since',
              //     prefix: LineAwesomeIcons.times),
              defaultFormField(
                  onSaved: (value) {},
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.parse('1960-01-01'),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      sinceController.text =
                          DateFormat('yyyy-MM-dd').format(value!);
                    });
                  },
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: sinceController,
                  type: TextInputType.datetime,
                  validate: (value) {
                    return null;
                  },
                  label: 'Since',
                  prefix: Icons.date_range),
              SizedBox(height: 20),
              defaultFormField(
                  controller: stateController,
                  type: TextInputType.text,
                  validate: (validate) {
                    return null;
                  },
                  label: 'State',
                  prefix: LineAwesomeIcons.damaged_house),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
