import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/pages/medication/shared_componenets/divider_line.dart';
import 'package:final_pro/pages/medication/shared_componenets/date_text_field.dart';
import 'package:final_pro/pages/medication/shared_componenets/dose_text_field.dart';
import 'package:final_pro/pages/medication/shared_componenets/drug_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../cubits/medication_cubits/create_medication_cubit/create_medication_cubit.dart';
import '../../../models/min_drug_model.dart';

class MedicationItem extends StatefulWidget {
  const MedicationItem({Key? key}) : super(key: key);

  @override
  State<MedicationItem> createState() => _MedicationItemState();
}

class _MedicationItemState extends State<MedicationItem> {
  @override
  void initState() {
    BlocProvider.of<CreateMedicationCubit>(context).addNewMedicationItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    final bloc = BlocProvider.of<CreateMedicationCubit>(context);
    //
    return BlocBuilder<CreateMedicationCubit, CreateMedicationState>(
      builder: (context, state) {
        // if (state is GetMedicationState ||
        //     state is CreateMedicationLoadingState) {
        //
        // }
        // return ErrorBloc();
        return WillPopScope(
          onWillPop: () async {
            bloc.dispose();
            return true;
          },
          child: Form(
            key: bloc.formKey2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i <= bloc.indexController; i++)
                    MedicationItemContainer(
                      context: context,
                      currentIndex: i,
                      showDivider: i == bloc.indexController ? false : true,
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MedicationItemContainer extends StatelessWidget {
  final BuildContext context;
  final int currentIndex;
  final bool showDivider;

  const MedicationItemContainer({
    Key? key,
    required this.context,
    required this.currentIndex,
    required this.showDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CreateMedicationCubit>(context);
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'Drug ${currentIndex + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: currentIndex == 0
                        ? Theme.of(context).disabledColor
                        : kErrorColor,
                  ),
                  onPressed: currentIndex == 0
                      ? null
                      : () {
                          bloc.removeMedicationItem(currentIndex);
                        },
                ),
              ],
            ),
          ],
        ),
        DrugSearchField(
          controller: bloc.drugTextControllerList[currentIndex],
          onSuggestionSelected: (MinDrugModel suggestion) {
            bloc.drugTextControllerList[currentIndex].text =
                suggestion.drugName!;
            bloc.selectedSuggestion[currentIndex].drugId = suggestion.drugId;
            bloc.selectedSuggestion[currentIndex].drugName =
                suggestion.drugName;
          },
        ),
        DoseTextField(
          controller: bloc.doseTextControllerList[currentIndex],
          readOnly: false,
        ),
        DateTextField(
          controller: bloc.startDateTextControllerList[currentIndex],
          readOnly: false,
          label: 'Start date',
          hintText: 'Enter dose start date',
          validationMessage: 'Please enter the dose start date',
        ),
        DateTextField(
          controller: bloc.endDateTextControllerList[currentIndex],
          readOnly: false,
          label: 'End date',
          hintText: 'Enter dose end date',
          validationMessage: 'Please enter the dose end date',
        ),
        showDivider
            ? DividerLine()
            : Row(
                children: [
                  Expanded(child: DividerLine()),
                  TextButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add new one!'),
                    onPressed: () {
                      bloc.addNewMedicationItem();
                    },
                  )
                ],
              )
      ],
    );
  }
}
