import 'package:final_pro/constants.dart';
import 'package:final_pro/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/center_progress_indicator.dart';
import '../../../components/error_bloc.dart';
import '../../../cubits/teams_cubit/teams_cubit.dart';
import 'buttons_container.dart';
import 'list_inside_container.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    //
    Widget getViewedList(dynamic state, bool isFollowersSelected) {
      if (role == "patient") {
        if (isFollowersSelected) {
          return ListInsideContainer(viewedList: state.model.followers);
        } else
          return ListInsideContainer(viewedList: state.model.followings);
      } else {
        return ListInsideContainer(viewedList: state.model.followings);
      }
    }

    //
    BlocProvider.of<TeamsCubit>(context).getFollowingInfo();
    SizeConfig()..init(context);
    //
    return BlocConsumer<TeamsCubit, TeamsState>(
      listener: (context, state) {
        if (state is GetFollowingStateWithToast) {
          showCentralToast(text: 'Done!', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        bool isFollowersSelected =
            BlocProvider.of<TeamsCubit>(context).isFollowersSelected;
        if (state is TeamsLoadingState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: CenterProgressIndicator(),
                  height: SizeConfig.screenHeightUnderAppAndStatusBar * 0.74,
                ),
                ButtonsContainer(),
              ],
            ),
          );
        }
        //
        else if (state is TeamsErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        //
        else if (state is GetFollowingStateWithToast) {
          //
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getViewedList(state, isFollowersSelected),
                ButtonsContainer(),
              ],
            ),
          );
        } //
        else if (state is GetFollowingStateNoToast) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getViewedList(state, isFollowersSelected),
                ButtonsContainer(),
              ],
            ),
          );
        }
        return ErrorBloc();
      },
    );

    // return Container(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         SizedBox(height: 30),
    //         Container(
    //             margin: EdgeInsets.all(8),
    //             child: Row(
    //               children: [
    //                 ElevatedButton(
    //                     onPressed: () {},
    //                     style: ElevatedButton.styleFrom(
    //                         primary: Colors.green, minimumSize: Size(50, 50)),
    //                     child: Text(
    //                       "create invitation",
    //                       style: TextStyle(
    //                         fontSize: 20,
    //                       ),
    //                     )),
    //                 Spacer(),
    //                 ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         primary: Colors.green, minimumSize: Size(50, 50)),
    //                     onPressed: () {},
    //                     child: Text(
    //                       "use invitation",
    //                       style: TextStyle(fontSize: 20),
    //                     ))
    //               ],
    //             )),
    //         SizedBox(height: 20),
    //         Container(
    //           margin: EdgeInsets.all(6.0),
    //           child: Column(
    //             children: [
    //               Text(
    //                 "follower1",
    //                 style: TextStyle(color: Colors.green, fontSize: 40),
    //               ),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Text(
    //                 "follower2",
    //                 style: TextStyle(color: Colors.green, fontSize: 40),
    //               ),
    //               SizedBox(height: 20),
    //               Text(
    //                 "follower3",
    //                 style: TextStyle(color: Colors.green, fontSize: 40),
    //               ),
    //               SizedBox(height: 20),
    //               Text(
    //                 "follower4",
    //                 style: TextStyle(color: Colors.green, fontSize: 40),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
