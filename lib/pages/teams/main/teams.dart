import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubits/teams_cubit/teams_cubit.dart';
import '../../../size_config.dart';
import '../main/components/body.dart';
import '../main/components/buttons_container.dart';

class Teams extends StatefulWidget {
  static String routeName = "/teams";

  const Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> with TickerProviderStateMixin {
  late TabController _tabController;
  final bool isPatient = role == 'patient';
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: isPatient ? 2 : 1, vsync: this);
    BlocProvider.of<TeamsCubit>(context).getFollowingInfo();
  }

  @override
  Widget build(BuildContext context) {
    print('Why get built ???????????????????????');
    // SizeConfig()..init(context);
    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Teams"),
        bottom: isPatient
            ? TabBar(
                onTap: (index) {
                  if (index == 0) {
                    //followers Tap
                    BlocProvider.of<TeamsCubit>(context).isFollowersTab = true;
                  } else {
                    BlocProvider.of<TeamsCubit>(context).isFollowersTab = false;
                  }
                  print(BlocProvider.of<TeamsCubit>(context).isFollowersTab);
                },
                controller: _tabController,
                tabs: <Widget>[
                  Tab(child: Text('Followers')),
                  Tab(child: Text('Followings')),
                ],
              )
            : TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(child: Text('Followings')),
                ],
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: isPatient
                  ? SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                      kContainerOfTeamsListRatioForPatients
                  : SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                      kContainerOfTeamsListRatioForDoctors,
              child: TabBarView(
                controller: _tabController,
                children: isPatient
                    ? <Widget>[
                        Body(isFollowersSelected: true),
                        Body(isFollowersSelected: false),
                      ]
                    : <Widget>[
                        Body(isFollowersSelected: false),
                      ],
              ),
            ),
            ButtonsContainer(isPatient: isPatient),
          ],
        ),
      ),
    );
  }
}
