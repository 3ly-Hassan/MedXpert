import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../size_config.dart';
import 'follower_card.dart';
import 'no_followers_widget.dart';

class ListInsideContainer extends StatelessWidget {
  final List viewedList;
  const ListInsideContainer({Key? key, required this.viewedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<TeamsCubit>(context).getFollowingInfo();
      },
      child: Container(
        height: SizeConfig.screenHeightUnderAppAndStatusBar * 0.74,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: viewedList.isEmpty
            ? NoFollowersWidget(
                msg: BlocProvider.of<TeamsCubit>(context).isFollowersSelected
                    ? kNoFollowersYet
                    : kNoFollowingsYet,
              )
            : ListView.builder(
                itemCount: viewedList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
                    child: FollowerCard(follower: viewedList[index]),
                  );
                }),
      ),
    );
  }
}
