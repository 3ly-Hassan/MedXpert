import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../profileConstants.dart';

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool? hasNavigation;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit * 4,
      ).copyWith(
        bottom: kSpacingUnit * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit * 3),
        color: Colors.black,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: kSpacingUnit * 2.5,
            color: Colors.amberAccent,
          ),
          SizedBox(width: kSpacingUnit * 1.5),
          Text(
            this.text!,
            style: kTitleTextStyle.copyWith(
              color: Colors.amberAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation!)
            Icon(
              LineAwesomeIcons.angle_right,
              size: kSpacingUnit * 2.5,
            ),
        ],
      ),
    );
  }
}
