import 'package:flutter/material.dart';

import '../../../components/some_shared_components.dart';
import '../../../date_helper.dart';

class DateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String validationMessage;
  final bool readOnly;
  const DateTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.validationMessage,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: defaultFormField(
        controller: controller,
        readOnly: true,
        label: label,
        hintText: hintText,
        suffix: Icons.date_range,
        onTap: readOnly
            ? null
            : () {
                _selectDate(
                  context,
                  controller,
                );
              },
        validate: (value) {
          if (value!.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}
