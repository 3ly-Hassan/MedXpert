import 'package:final_pro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/center_progress_indicator.dart';
import '../../../components/error_bloc.dart';
import '../../../cubits/teams_cubit/teams_cubit.dart';
import 'get_viewed_list.dart';

class Body extends StatelessWidget {
  final isFollowersSelected;
  const Body({Key? key, required this.isFollowersSelected}) : super(key: key);

  Widget build(BuildContext context) {
    //
    return BlocConsumer<TeamsCubit, TeamsState>(
      listener: (context, state) {
        if (state is GetFollowingStateWithToast) {
          showCentralToast(text: 'Done!', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        if (state is TeamsLoadingState) {
          return CenterProgressIndicator();
        }
        //
        else if (state is TeamsErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        //
        else if (state is GetFollowingStateWithToast ||
            state is GetFollowingStateNoToast) {
          //
          return GetViewedList(
              state: state, isFollowersSelected: isFollowersSelected);
        } //
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
