import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/pages/medication/medication_details_screen.dart';
import 'package:final_pro/pages/teams/components/follower_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import 'create_medication_screen.dart';

class MedicationScreen extends StatefulWidget {
  static String routeName = "/medication";

  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  void initState() {
    BlocProvider.of<MedicationCubit>(context).getPatientList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medication',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateMedicationScreen.routeName);
        },
      ),
      body: BlocBuilder<MedicationCubit, MedicationState>(
        builder: (context, state) {
          if (state is MedicationLoadingState) {
            return CenterProgressIndicator();
          } else if (state is GetPatientListState) {
            return ListView.builder(
              itemCount: state.patientList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
                  child: FollowerCard(
                    follower: state.patientList[index],
                    showTextButton: false,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MedicationDetailsScreen.routeName);
                    },
                  ),
                );
              },
            );
          }
          return ErrorBloc();
        },
      ),
    );
  }
}
