import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/pages/medication/divider_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../components/center_progress_indicator.dart';
import '../../components/some_shared_components.dart';
import '../../cubits/medication_cubits/medication_details_cubit/medication_details_cubit.dart';
import '../../date_helper.dart';
import '../../models/min_drug_model.dart';
import '../../size_config.dart';

class MedicationItem extends StatefulWidget {
  const MedicationItem({Key? key}) : super(key: key);

  @override
  State<MedicationItem> createState() => _MedicationItemState();
}

class _MedicationItemState extends State<MedicationItem> {
  @override
  void initState() {
    BlocProvider.of<MedicationDetailsCubit>(context).addNewMedicationItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    final bloc = BlocProvider.of<MedicationDetailsCubit>(context);
    final _formKey = GlobalKey<FormState>();
    //
    return BlocBuilder<MedicationDetailsCubit, MedicationDetailsState>(
      builder: (context, state) {
        if (state is GetMedicationState) {
          return WillPopScope(
            onWillPop: () async {
              bloc.dispose();
              return true;
            },
            child: Form(
              key: _formKey,
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
        }
        return ErrorBloc();
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

  Future<void> _selectDate(
      BuildContext context, TextEditingController textController) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      textController.text = DateHelper.getFormattedString(
          date: picked, formattedString: 'yyyy-M-dd');
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MedicationDetailsCubit>(context);
    List drugSearchList = [];
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
                        : Theme.of(context).errorColor,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
              controller: bloc.drugTextControllerList[currentIndex],
              decoration: InputDecoration(
                  labelText: 'Drug',
                  hintText: 'Enter a drug name',
                  suffixIcon: Icon(Icons.medical_services_outlined)),
            ),
            suggestionsCallback: (pattern) async {
              drugSearchList = (await bloc.searchForDrug(pattern))!;
              return drugSearchList as List<MinDrugModel>;
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
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (MinDrugModel suggestion) {
              bloc.drugTextControllerList[currentIndex].text =
                  suggestion.drugName!;
              bloc.selectedSuggestion[currentIndex].drugId = suggestion.drugId;
              bloc.selectedSuggestion[currentIndex].drugName =
                  suggestion.drugName;
            },
            validator: (value) {
              bool inSearchResult =
                  drugSearchList.any((element) => element.drugName == value);
              if (value!.isEmpty) {
                return 'Please Enter a drug name';
              } else if (!inSearchResult) {
                return 'Please select a valid drug name';
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: defaultFormField(
            controller: bloc.doseTextControllerList[currentIndex],
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
            controller: bloc.startDateTextControllerList[currentIndex],
            readOnly: true,
            label: 'Start date',
            hintText: 'Enter dose start date',
            suffix: Icons.date_range,
            onTap: () {
              _selectDate(
                context,
                bloc.startDateTextControllerList[currentIndex],
              );
            },
            validate: (validate) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: defaultFormField(
            controller: bloc.endDateTextControllerList[currentIndex],
            readOnly: true,
            label: 'End date',
            hintText: 'Enter dose end date',
            suffix: Icons.date_range,
            onTap: () {
              _selectDate(
                context,
                bloc.endDateTextControllerList[currentIndex],
              );
            },
            validate: (validate) {},
          ),
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
