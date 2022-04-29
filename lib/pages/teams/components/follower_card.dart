import 'package:final_pro/dialog_helper.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class FollowerCard extends StatelessWidget {
  final Follower follower;
  final Function? onTap;
  final bool showTextButton;

  const FollowerCard({
    Key? key,
    required this.follower,
    this.onTap,
    this.showTextButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null
          ? null
          : () {
              onTap!();
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.green.shade100,
        ),
        child: ListTile(
          title: Text(follower.username!, overflow: TextOverflow.ellipsis),
          subtitle: Text(follower.email!, overflow: TextOverflow.ellipsis),
          trailing: showTextButton
              ? TextButton(
                  child: Text(
                    kUnFollow,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    DialogHelper.deleteDialog(context, follower);
                  },
                )
              : null,
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: follower.isPatient!
                ? follower.gender == 'male'
                    ? AssetImage('assets/images/male_patient.png')
                    : AssetImage('assets/images/female_patient.png')
                : AssetImage('assets/images/doctor.jpg'),
          ),
        ),
      ),
    );
  }
}
