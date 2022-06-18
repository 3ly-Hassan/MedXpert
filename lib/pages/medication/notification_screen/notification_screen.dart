import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/dialog_helper.dart';
import 'package:final_pro/pages/teams/components/no_followers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/medication_cubits/notification_cubit/notification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = "/notification_screen";
  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drugName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(drugName),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadingState) {
            return CenterProgressIndicator();
          } else if (state is GetNotificationListState) {
            //
            return state.notificationList.isEmpty
                ? NoFollowersWidget(msg: 'No notifications yet')
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: state.notificationList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: kPrimaryColorLight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Date: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: state
                                                .notificationList[index].date,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Time: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: state
                                                .notificationList[index].time,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final bool isToDelete = await DialogHelper
                                      .deleteNotificationDialog(context);
                                  if (isToDelete) {
                                    await BlocProvider.of<NotificationCubit>(
                                            context)
                                        .deleteNotification(
                                      state.notificationList[index]
                                          .notificationId,
                                      state
                                          .notificationList[index].drugUniqueId,
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
          }
          return ErrorBloc();
        },
      ),
    );
  }
}
