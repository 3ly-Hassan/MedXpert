import 'package:flutter/material.dart';

import '../../../components/some_shared_components.dart';

class DoseTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  const DoseTextField(
      {Key? key, required this.controller, required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: defaultFormField(
        controller: controller,
        type: TextInputType.number,
        readOnly: readOnly,
        label: 'Daily dose',
        hintText: 'Enter the drug dose',
        prefix: null,
        suffix: Icons.medical_services,
        validate: (value) {
          if (value!.isEmpty) {
            return 'Please enter the dose';
          }
          return null;
        },
      ),
    );
  }
}
