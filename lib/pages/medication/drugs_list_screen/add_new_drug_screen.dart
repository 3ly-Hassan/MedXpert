import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/models/medication_drug.dart';
import 'package:final_pro/pages/medication/shared_componenets/create_button.dart';
import 'package:final_pro/pages/medication/shared_componenets/date_text_field.dart';
import 'package:final_pro/pages/medication/shared_componenets/dose_text_field.dart';
import 'package:final_pro/pages/medication/shared_componenets/drug_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';
import '../../../models/medication.dart';
import '../../../models/min_drug_model.dart';
import '../../../size_config.dart';

class AddNewDrugScreen extends StatefulWidget {
  static String routeName = "/add_new_drug_screen";

  const AddNewDrugScreen({Key? key}) : super(key: key);

  @override
  State<AddNewDrugScreen> createState() => _AddNewDrugScreenState();
}

class _AddNewDrugScreenState extends State<AddNewDrugScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedDrugId = '';

  TextEditingController drugTextController = TextEditingController();
  TextEditingController doseTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  TextEditingController endDateTextController = TextEditingController();
  @override
  void dispose() {
    drugTextController.dispose();
    doseTextController.dispose();
    startDateTextController.dispose();
    endDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new drug'),
        backgroundColor: kAppBarColor,
      ),
      body: BlocConsumer<DrugsListCubit, DrugsListState>(
        listener: (context, state) {
          if (state is AddingDrugSuccessState) {
            showToast(
                text: 'Drug successfully added', state: ToastStates.SUCCESS);
          } else if (state is AddingDrugFailedState) {
            showToast(text: 'Adding failed', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                      kContainerOfCreateMedicationListRatio,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          DrugSearchField(
                              controller: drugTextController,
                              onSuggestionSelected: (MinDrugModel suggestion) {
                                drugTextController.text = suggestion.drugName!;
                                selectedDrugId = suggestion.drugId!;
                              }),
                          DoseTextField(
                              controller: doseTextController, readOnly: false),
                          DateTextField(
                              controller: startDateTextController,
                              label: 'Start date',
                              hintText: 'Enter dose start date',
                              validationMessage:
                                  'Please enter the dose start date',
                              readOnly: false),
                          DateTextField(
                              controller: endDateTextController,
                              label: 'End date',
                              hintText: 'Enter dose end date',
                              validationMessage:
                                  'Please enter the end start date',
                              readOnly: false),
                        ],
                      ),
                    ),
                  ),
                ),
                state is DrugsListLoadingState
                    ? CenterProgressIndicator()
                    : CreateButton(
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            await BlocProvider.of<DrugsListCubit>(context)
                                .addDrugToMedication(
                              BlocProvider.of<DrugsListCubit>(context)
                                  .medicationItem
                                  .id!,
                              MedicationDrug(
                                drugId: selectedDrugId,
                                drugName: drugTextController.text,
                                dose: int.parse(doseTextController.text),
                                startDate: startDateTextController.text,
                                endDate: endDateTextController.text,
                              ),
                              context,
                            );
                          }
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
