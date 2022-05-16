import 'package:flutter/material.dart';

import '../create_medication_screen/create_medication_screen.dart';

Widget createMedicationFloatingButton(BuildContext context) {
  return FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {
      Navigator.of(context).pushNamed(CreateMedicationScreen.routeName);
    },
  );
}
