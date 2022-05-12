import 'package:final_pro/models/medication.dart';
import 'package:flutter/material.dart';

class DrugsListScreen extends StatelessWidget {
  static String routeName = "/drug_list_screen";

  const DrugsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final medication = ModalRoute.of(context)!.settings.arguments as Medication;
    return Scaffold(
      appBar: AppBar(
        title: Text('Drugs list'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // body:
    );
  }
}
