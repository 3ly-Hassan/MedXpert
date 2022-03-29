import 'package:final_pro/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowerCard extends StatelessWidget {
  final Follower follower;

  const FollowerCard({Key? key, required this.follower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).primaryColorLight,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: follower.gender == 'male'
              ? AssetImage('assets/images/profile.png')
              : AssetImage('assets/images/doctor.jpg'),
        ),
        title: Text(follower.username!),
        subtitle: Text(follower.email!),
      ),
    );

    // return Container(
    //   width: double.infinity,
    //   color: Colors.amber,
    //   height: 130,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 30,
    //       ),
    //       Stack(
    //         alignment: Alignment.centerLeft,
    //         children: [
    //           Container(
    //             color: Colors.red,
    //             width: double.infinity,
    //             height: 80,
    //           ),
    //           CircleAvatar(
    //             radius: 25,
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
