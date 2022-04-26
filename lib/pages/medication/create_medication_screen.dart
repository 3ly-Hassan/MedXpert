import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/cubits/medication_cubit/medication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/some_shared_components.dart';
import '../../constants.dart';
import '../../size_config.dart';

class CreateMedicationScreen extends StatefulWidget {
  static String routeName = "/create_medication";
  const CreateMedicationScreen({Key? key}) : super(key: key);

  @override
  State<CreateMedicationScreen> createState() => _CreateMedicationScreenState();
}

class _CreateMedicationScreenState extends State<CreateMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _doseTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic selectedItem;
    List<DropdownMenuItem> dropDownPatients =
        BlocProvider.of<MedicationCubit>(context)
            .patientList
            .map<DropdownMenuItem<String>>(
      (element) {
        return DropdownMenuItem<String>(
          value: element.username,
          child: Text(element.username),
        );
      },
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create medication',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                kContainerOfCreateMedicationListRatio,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<dynamic>(
                        onChanged: (item) {
                          selectedItem = item;
                        },
                        items: dropDownPatients,
                        hint: Text('Select a patient'),
                        validator: (item) {
                          if (item == null) {
                            print('probleeeeeeeeeeeeeeeeeeeeeeeeeem');
                          }
                        },
                      ),
                    ),
                  ),
                  // defaultFormField(
                  //   controller: _doseTextController,
                  // )
                ],
              ),
            ),
          ),
          Container(
            height: SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                kContainerOfMedicationCreationButton,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButton(
                  text: 'Create',
                  press: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
