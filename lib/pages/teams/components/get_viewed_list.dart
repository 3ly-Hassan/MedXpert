import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/patient.dart';
import 'list_inside_container.dart';

class GetViewedList extends StatelessWidget {
  final isFollowersSelected;
  final state;
  const GetViewedList(
      {Key? key, required this.state, required this.isFollowersSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (role == "patient") {
      if (isFollowersSelected) {
        return ListInsideContainer(viewedList: state.model.followers);
      } else
        return ListInsideContainer(viewedList: state.model.followings);
    } else {
      return ListInsideContainer(viewedList: state.model.followings);
    }
  }
}
