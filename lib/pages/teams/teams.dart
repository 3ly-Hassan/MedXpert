import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../cubits/teams_cubit/teams_cubit.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/buttons_container.dart';

class Teams extends StatefulWidget {
  static String routeName = "/teams";

  const Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<TeamsCubit>(context).getFollowingInfo();
  }

  @override
  Widget build(BuildContext context) {
    print('Why get built ???????????????????????');
    // SizeConfig()..init(context);
    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Teams"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(child: Text('Followers')),
            Tab(child: Text('Followings')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
                  kContainerOfTeamsListRatio,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Body(isFollowersSelected: true),
                  Body(isFollowersSelected: false),
                ],
              ),
            ),
            ButtonsContainer(),
          ],
        ),
      ),
    );
  }
}
