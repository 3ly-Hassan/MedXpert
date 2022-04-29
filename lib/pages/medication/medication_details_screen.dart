import 'package:flutter/material.dart';

class MedicationDetailsScreen extends StatefulWidget {
  static String routeName = "/medication_details";

  const MedicationDetailsScreen({Key? key}) : super(key: key);

  // final routeArgs;
  @override
  State<MedicationDetailsScreen> createState() =>
      _MedicationDetailsScreenState();
}

class _MedicationDetailsScreenState extends State<MedicationDetailsScreen> {
  @override
  void initState() {
    // Navigator.of(context)
    //     .pushNamed('category_meals', arguments: {'id': id, 'title': title});
    //
    // routeArgs = ModalRoute.of(context)?.settings.arguments as Map;
    // final acceptedId = routeArgs['id'];
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication details'),
      ),
      body: Container(),
    );
  }
}
