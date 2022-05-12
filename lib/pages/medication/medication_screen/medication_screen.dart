import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/cubits/medication_cubits/medications_list_cubit/medications_list_cubit.dart';
import 'package:final_pro/pages/teams/components/follower_card.dart';
import 'package:final_pro/pages/teams/components/no_followers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import '../create_medication_screen/create_medication_screen.dart';
import '../medications_list_screen/medications_list_screen.dart';

class MedicationScreen extends StatefulWidget {
  static String routeName = "/medication";

  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  void initState() {
    BlocProvider.of<MedicationCubit>(context).getFollowersList();
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
          } else if (state is GetFollowersListState) {
            return state.followersList.isEmpty
                ? NoFollowersWidget(msg: 'No patients yet')
                : ListView.builder(
                    itemCount: state.followersList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
                        child: FollowerCard(
                          follower: state.followersList[index],
                          showTextButton: false,
                          onTap: () async {
                            Navigator.of(context)
                                .pushNamed(MedicationsListScreen.routeName);
                            await BlocProvider.of<MedicationsListCubit>(context)
                                .getMedicationsList(
                                    state.followersList[index].id);
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
