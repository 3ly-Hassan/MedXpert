import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../components/center_progress_indicator.dart';
import '../../../cubits/medication_cubits/create_medication_cubit/create_medication_cubit.dart';
import '../../../models/min_drug_model.dart';
import '../../../size_config.dart';

class DrugSearchField extends StatefulWidget {
  final TextEditingController controller;
  final Function onSuggestionSelected;

  const DrugSearchField({
    Key? key,
    required this.controller,
    required this.onSuggestionSelected,
  }) : super(key: key);

  @override
  State<DrugSearchField> createState() => _DrugSearchFieldState();
}

class _DrugSearchFieldState extends State<DrugSearchField> {
  List drugSearchList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Drug',
            hintText: 'Enter a drug name',
            suffixIcon: Icon(Icons.medical_services_outlined),
          ),
        ),
        suggestionsCallback: (pattern) async {
          drugSearchList =
              (await BlocProvider.of<CreateMedicationCubit>(context)
                  .searchForDrug(pattern))!;
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
          widget.onSuggestionSelected(suggestion);
        },
        validator: (value) {
          bool inSearchResult =
              drugSearchList.any((element) => element.drugName == value);
          if (value!.isEmpty) {
            return 'Please Enter a drug name';
          } else if (!inSearchResult) {
            return 'Please select a valid drug name';
          }
          return null;
        },
      ),
    );
  }
}
