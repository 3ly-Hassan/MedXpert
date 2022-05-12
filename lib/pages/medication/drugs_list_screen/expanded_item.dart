import 'package:final_pro/pages/medication/shared_componenets/drug_search_field.dart';
import 'package:flutter/material.dart';

import '../../../components/some_shared_components.dart';
import '../../../constants.dart';
import '../shared_componenets/date_text_field.dart';
import '../shared_componenets/dose_text_field.dart';

ExpansionPanel expandedItem({
  required bool isExpanded,
  required bool isEditing,
  required String drugName,
  required int dose,
  required String startDate,
  required String endDate,
}) {
  TextEditingController drugController = TextEditingController(text: drugName);
  TextEditingController doseController = TextEditingController(text: '$dose');
  TextEditingController startDateController =
      TextEditingController(text: startDate);
  TextEditingController endDateController =
      TextEditingController(text: endDate);
  return ExpansionPanel(
    isExpanded: isExpanded,
    headerBuilder: (context, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(drugName),
      );
    },
    body: isExpanded
        ? SingleChildScrollView(
            child: Column(
              children: [
                isEditing
                    ? DrugSearchField(
                        controller: TextEditingController(text: drugName),
                        onSuggestionSelected: (_) {},
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                        child: defaultFormField(
                          controller:
                              TextEditingController(text: 'comming name'),
                          readOnly: true,
                          label: 'Drug',
                          hintText: 'Enter a drug name',
                          suffix: Icons.medical_services,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the drug name';
                            }
                            return null;
                          },
                        ),
                      ),
                DoseTextField(
                  controller: TextEditingController(),
                  readOnly: true,
                ),
                DateTextField(
                  controller: TextEditingController(),
                  label: 'Start date',
                  hintText: 'Enter dose start date',
                  validationMessage: 'Please enter the dose end date',
                  readOnly: true,
                ),
                DateTextField(
                  controller: TextEditingController(),
                  label: 'End date',
                  hintText: 'Enter dose end date',
                  validationMessage: 'Please enter the dose end date',
                  readOnly: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: kErrorColor,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(),
  );
}
