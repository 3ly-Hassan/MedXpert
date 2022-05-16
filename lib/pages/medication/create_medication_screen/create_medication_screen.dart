import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/cubits/medication_cubits/create_medication_cubit/create_medication_cubit.dart';
import 'package:final_pro/models/patient.dart';
import 'package:final_pro/pages/medication/create_medication_screen/medication_item.dart';
import 'package:final_pro/pages/medication/shared_componenets/create_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../components/some_shared_components.dart';
import '../../../constants.dart';
import '../../../cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import '../../../size_config.dart';
import '../shared_componenets/divider_line.dart';

class CreateMedicationScreen extends StatefulWidget {
  static String routeName = "/create_medication";
  const CreateMedicationScreen({Key? key}) : super(key: key);

  @override
  State<CreateMedicationScreen> createState() => _CreateMedicationScreenState();
}

class _CreateMedicationScreenState extends State<CreateMedicationScreen> {
  Follower? _selectedPatient;
  TextEditingController medicationName = TextEditingController();

  @override
  void dispose() {
    medicationName.dispose();
    super.dispose();
  }

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
        child: BlocConsumer<CreateMedicationCubit, CreateMedicationState>(
          listener: (context, state) {
            if (state is CreateMedicationSuccess) {
              showToast(text: 'Medication created', state: ToastStates.SUCCESS);
            } else if (state is CreateMedicationFailed)
              showToast(text: 'Creation failed', state: ToastStates.ERROR);
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height:
                        SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                            kContainerOfCreateMedicationListRatio,
                    child: Form(
                      key: BlocProvider.of<CreateMedicationCubit>(context)
                          .formKey1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            role == 'doctor'
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 20, 16, 8),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField2<Follower>(
                                        onChanged: (item) {
                                          _selectedPatient = item!;
                                        },
                                        dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        decoration: InputDecoration(
                                          labelText: 'Patient',
                                          hintText: 'Select a patient',
                                          suffixIcon:
                                              Icon(Icons.accessibility_sharp),
                                        ),
                                        items: dropDownPatients,
                                        validator: (item) {
                                          if (item == null) {
                                            return 'Please select a patient';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                              child: defaultFormField(
                                controller: medicationName,
                                readOnly: false,
                                label: 'Medication name',
                                hintText: 'Enter the medication name',
                                prefix: null,
                                suffix: Icons.medical_services,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the the medication name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            DividerLine(),
                            MedicationItem(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  state is CreateMedicationLoadingState
                      ? CenterProgressIndicator()
                      : CreateButton(
                          onPress: () async {
                            await BlocProvider.of<CreateMedicationCubit>(
                                    context)
                                .createMedication(
                              _selectedPatient == null
                                  ? ''
                                  : _selectedPatient!.id,
                              medicationName.text,
                              context,
                            );
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
