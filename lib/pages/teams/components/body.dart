import 'package:final_pro/components/default_button.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/dialog_helper.dart';
import 'package:final_pro/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/teams_cubit/teams_cubit.dart';
import '../../../models/patient.dart';
import 'follower_card.dart';

List list = [
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
  FollowerCard(
    follower: Follower(
      username: "userName",
      email: "email",
      gender: "male",
    ),
  ),
];

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final x = BlocProvider.of<TeamsCubit>(context).getFollowingInfo();

    SizeConfig()..init(context);
    return BlocConsumer<TeamsCubit, TeamsState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (state is TeamsLoadingState) {
        //   return CenterProgressIndicator();
        // }
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.71,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
                        child: list[index],
                      );
                    }),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    DefaultButton(
                      text: kCreateInvitation,
                      press: () async {
                        BlocProvider.of<TeamsCubit>(context)
                            .emitDialogLoadingSpinner();
                        DialogHelper.createInvitationDialog(context);
                        await BlocProvider.of<TeamsCubit>(context)
                            .createInvitationEvent();
                      },
                    ),
                    Spacer(),
                    DefaultButton(
                      text: kUseInvitation,
                      press: () {
                        textController.clear();
                        DialogHelper.useInvitationDialog(
                            context, textController);
                      },
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
                height: SizeConfig.screenHeight * 0.18,
                // color: Colors.amber,
              ),
            ],
          ),
        );
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
