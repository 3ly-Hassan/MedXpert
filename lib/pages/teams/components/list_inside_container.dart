import 'package:flutter/cupertino.dart';

import '../../../size_config.dart';
import 'follower_card.dart';

class ListInsideContainer extends StatelessWidget {
  final List viewedList;
  const ListInsideContainer({Key? key, required this.viewedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.71,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView.builder(
          itemCount: viewedList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
              child: FollowerCard(follower: viewedList[index]),
            );
          }),
    );
  }
}
