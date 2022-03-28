import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddChronics extends StatelessWidget {
  AddChronics({Key? key}) : super(key: key);
  static String routeName = "/addChronics";
  var nameController = TextEditingController();
  var sinceController = TextEditingController();
  var stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Add to your Chronics'),
        actions: [
          IconButton(
              onPressed: () {
                var model = Chronics();
                model.chronicName = nameController.text;
                model.since = sinceController.text;
                model.state = stateController.text;
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            defaultFormField(
                controller: nameController,
                type: TextInputType.text,
                validate: (validate) {
                  return null;
                },
                label: 'Name',
                prefix: LineAwesomeIcons.address_book),
            SizedBox(height: 20),
            defaultFormField(
                controller: sinceController,
                type: TextInputType.number,
                validate: (validate) {
                  return null;
                },
                label: 'Since',
                prefix: LineAwesomeIcons.times),
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
    );
  }
}
