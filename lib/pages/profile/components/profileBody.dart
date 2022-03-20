import 'package:conditional_builder/conditional_builder.dart';
import 'package:final_pro/cubits/ProfileCubit/cubit.dart';
import 'package:final_pro/cubits/ProfileCubit/states.dart';
import 'package:final_pro/pages/profile/components/profile_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../profileConstants.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileInfo = ProfileCubit.get(context).patient != null
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Icon(
                        LineAwesomeIcons.arrow_left,
                        size: kSpacingUnit * 3,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 10 * 10,
                  width: 10 * 10,
                  margin: EdgeInsets.only(top: 10 * 3),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 10 * 5,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kSpacingUnit * 1),
                Text(
                  ProfileCubit.get(context).patient!.username!,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 28),
                ),
                SizedBox(height: kSpacingUnit * .01),
                Text(
                  ProfileCubit.get(context).patient!.email!,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kSpacingUnit * 1.0),
                Container(
                  height: kSpacingUnit * 4,
                  width: kSpacingUnit * 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingUnit * 3),
                    color: Colors.amberAccent,
                  ),
                  child: Center(
                    child: Text(
                      'Edit your profile',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        : Container();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: ProfileCubit.get(context).patient != null,
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: kSpacingUnit * 5),
              profileInfo,
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    ProfileListItem(
                      icon: LineAwesomeIcons.user_shield,
                      text: 'Privacy',
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.history,
                      text: 'Purchase History',
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.question_circle,
                      text: 'Help & Support',
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.cog,
                      text: 'Settings',
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.user_plus,
                      text: 'Invite a Friend',
                    ),
                    ProfileListItem(
                      icon: LineAwesomeIcons.alternate_sign_out,
                      text: 'Logout',
                      hasNavigation: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
