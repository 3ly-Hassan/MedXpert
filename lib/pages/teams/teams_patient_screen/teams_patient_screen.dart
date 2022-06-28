import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/cubits/teams_cubit/teams_patient_cubit/teams_patient_cubit.dart';
import 'package:final_pro/pages/teams/main/components/no_followers_widget.dart';
import 'package:final_pro/pages/teams/teams_patient_screen/chronic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsPatientScreen extends StatefulWidget {
  const TeamsPatientScreen({Key? key}) : super(key: key);
  static String routeName = '/teams_patient_screen';

  @override
  State<TeamsPatientScreen> createState() => _TeamsPatientScreenState();
}

class _TeamsPatientScreenState extends State<TeamsPatientScreen>
    with SingleTickerProviderStateMixin {
  //
  late TabController _tabController;
  //
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    final title = ModalRoute.of(context)?.settings.arguments as String;
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
        bottom: TabBar(
          onTap: (index) {
            if (index == 0) {
            } else {}
          },
          controller: _tabController,
          tabs: <Widget>[
            Tab(child: Text('Measurements')),
            Tab(child: Text('Chronics')),
          ],
        ),
      ),
      body: BlocBuilder<TeamsPatientCubit, TeamsPatientState>(
        builder: (context, state) {
          if (state is TeamsPatientLoadingState) {
            return CenterProgressIndicator();
          } else if (state is TeamsPatientErrorState) {
            return Center(
              child: Text(
                'Opps! An error has been occurred',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (state is GetPatientInfoState) {
            return TabBarView(
              controller: _tabController,
              children: <Widget>[
                state.measurements.isEmpty
                    ? NoFollowersWidget(msg: 'No measurements yet')
                    //TODO: You can start from here !
                    : Text('${state.measurements[0].condition}'),
                //till here.
                state.chronics.isEmpty
                    ? NoFollowersWidget(msg: 'No chronics yet')
                    : ListView.builder(
                        itemCount: state.chronics.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                8, index == 0 ? 10 : 0, 8, 10),
                            child: ChronicCard(
                              chronic: state.chronics[index],
                            ),
                          );
                        },
                      ),
              ],
            );
          }

          return ErrorBloc();
        },
      ),
    );
  }
}
