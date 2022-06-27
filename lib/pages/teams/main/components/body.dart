import 'package:final_pro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/center_progress_indicator.dart';
import '../../../../components/error_bloc.dart';
import '../../../../cubits/teams_cubit/teams_cubit.dart';
import 'get_viewed_list.dart';

class Body extends StatelessWidget {
  final isFollowersSelected;
  const Body({Key? key, required this.isFollowersSelected}) : super(key: key);

  Widget build(BuildContext context) {
    //
    return BlocConsumer<TeamsCubit, TeamsState>(
      listener: (context, state) {
        if (state is GetFollowingStateWithToast) {
          showToast(text: state.toastMessage, state: state.toastState);
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
  }
}
