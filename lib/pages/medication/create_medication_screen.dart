import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/cubits/medication_cubits/medication_details_cubit/medication_details_cubit.dart';
import 'package:final_pro/models/patient.dart';
import 'package:final_pro/pages/medication/medication_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../constants.dart';
import '../../cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import '../../size_config.dart';
import 'divider_line.dart';

class CreateMedicationScreen extends StatefulWidget {
  static String routeName = "/create_medication";
  const CreateMedicationScreen({Key? key}) : super(key: key);

  @override
  State<CreateMedicationScreen> createState() => _CreateMedicationScreenState();
}

class _CreateMedicationScreenState extends State<CreateMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late Follower _selectedPatient;

  @override
  Widget build(BuildContext context) {
    //
    List<DropdownMenuItem<Follower>> dropDownPatients =
        BlocProvider.of<MedicationCubit>(context)
            .patientList
            .map<DropdownMenuItem<Follower>>(
      (element) {
        return DropdownMenuItem<Follower>(
          value: element,
          child: Text(element.username),
        );
      },
    ).toList();
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create medication',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
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
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField2<Follower>(
                            onChanged: (item) {
                              _selectedPatient = item!;
                            },
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Patient',
                              hintText: 'Select a patient',
                              suffixIcon: Icon(Icons.accessibility_sharp),
                            ),
                            items: dropDownPatients,
                            validator: (item) {
                              if (item == null) {
                                print('probleeeeeeeeeeeeeeeeeeeeeeeeeem');
                              }
                            },
                          ),
                        ),
                      ),
                      DividerLine(),
                      MedicationItem(),
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
                      press: () {
                        List medicationList =
                            BlocProvider.of<MedicationDetailsCubit>(context)
                                .collectMedicationList();
                        BlocProvider.of<MedicationDetailsCubit>(context)
                            .createMedication(
                                _selectedPatient.id!, medicationList);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
