import 'dart:convert';

import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/components/some_shared_components.dart';
import 'package:final_pro/cubits/medication_cubits/medication_details_cubit/medication_details_cubit.dart';
import 'package:final_pro/date_helper.dart';
import 'package:final_pro/models/min_drug_model.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../constants.dart';
import '../../cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import '../../size_config.dart';

class CreateMedicationScreen extends StatefulWidget {
  static String routeName = "/create_medication";
  const CreateMedicationScreen({Key? key}) : super(key: key);

  @override
  State<CreateMedicationScreen> createState() => _CreateMedicationScreenState();
}

class _CreateMedicationScreenState extends State<CreateMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _drugTextController = TextEditingController();
  TextEditingController _doseTextController = TextEditingController();
  TextEditingController _startDateTextController = TextEditingController();
  TextEditingController _endDateTextController = TextEditingController();
  late Follower _selectedPatient;
  late MinDrugModel _selectedDrug;

  @override
  void dispose() {
    _drugTextController.dispose();
    _doseTextController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController textController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      textController.text = DateHelper.getFormattedString(
          date: picked, formattedString: 'yyyy-MMMM-dd');
    }
  }

  @override
  Widget build(BuildContext context) {
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

    List<DropdownMenuItem> dropDownDrugs = [];

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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        child: TypeAheadFormField(
                          debounceDuration: Duration(milliseconds: 800),
                          hideSuggestionsOnKeyboardHide: false,
                          minCharsForSuggestions: 2,
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            offsetX: 15,
                            hasScrollbar: true,
                            constraints: BoxConstraints(
                              // maxHeight: 150,
                              maxWidth: SizeConfig.screenWidth - 32 - 20,
                            ),
                          ),
                          loadingBuilder: (_) {
                            return Container(
                              constraints: BoxConstraints(maxHeight: 56),
                              child: CenterProgressIndicator(),
                            );
                          },
                          noItemsFoundBuilder: (_) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Container(
                                height: 30,
                                child: DropdownMenuItem(
                                  child: Text(
                                    'drug not found!',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _drugTextController,
                            decoration: InputDecoration(
                                labelText: 'Drug',
                                hintText: 'Enter a drug name',
                                suffixIcon:
                                    Icon(Icons.medical_services_outlined)),
                          ),
                          suggestionsCallback: (pattern) async {
                            final drugList =
                                await BlocProvider.of<MedicationDetailsCubit>(
                                        context)
                                    .searchForDrug(pattern);
                            return drugList as List<MinDrugModel>;
                          },
                          itemBuilder: (context, MinDrugModel suggestion) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              // child: Text(
                              //   suggestion.drugName!,
                              // ),
                              child: DropdownMenuItem(
                                child: Text(
                                  suggestion.drugName!,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (MinDrugModel suggestion) {
                            _drugTextController.text =
                                suggestion.drugName.toString();
                            _selectedDrug = suggestion;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select a city';
                            }
                          },
                          onSaved: (value) =>
                              _drugTextController.text = value.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        child: defaultFormField(
                          controller: _doseTextController,
                          type: TextInputType.number,
                          label: 'Dose',
                          hintText: 'Enter the drug dose',
                          prefix: null,
                          suffix: Icons.medical_services,
                          // validate: (validate) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        child: defaultFormField(
                          readOnly: true,
                          controller: _startDateTextController,
                          label: 'Start date',
                          hintText: 'Enter dose start date',
                          suffix: Icons.date_range,
                          onTap: () {
                            _selectDate(context, _startDateTextController);
                          },
                          validate: (validate) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        child: defaultFormField(
                          readOnly: true,
                          controller: _endDateTextController,
                          label: 'End date',
                          hintText: 'Enter dose end date',
                          suffix: Icons.date_range,
                          onTap: () {
                            _selectDate(context, _endDateTextController);
                          },
                          validate: (validate) {},
                        ),
                      )

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
                      press: () {
                        BlocProvider.of<MedicationDetailsCubit>(context)
                            .createMedication(_selectedPatient.id!, []);
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
