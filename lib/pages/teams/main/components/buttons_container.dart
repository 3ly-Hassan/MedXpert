import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/default_button.dart';
import '../../../../constants.dart';
import '../../../../cubits/dialog_cubit/dialog_cubit.dart';
import '../../../../dialog_helper.dart';
import '../../../../size_config.dart';

class ButtonsContainer extends StatefulWidget {
  final bool isPatient;
  const ButtonsContainer({Key? key, required this.isPatient}) : super(key: key);

  @override
  State<ButtonsContainer> createState() => _ButtonsContainerState();
}

class _ButtonsContainerState extends State<ButtonsContainer> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isPatient
          ? SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
              kContainerOfTeamsButtonsRatioForPatients
          : SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
              kContainerOfTeamsButtonsRatioForDoctors,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height:
                SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar * 0.011,
          ),
          widget.isPatient
              ? DefaultButton(
                  text: kCreateInvitation,
                  press: () async {
                    //show dialog at first, then call the method for creating invitation number
                    DialogHelper.createInvitationDialog(context);
                    await BlocProvider.of<DialogCubit>(context)
                        .createInvitationEvent();
                  },
                )
              : Container(),
          // Spacer(),
          DefaultButton(
            text: kUseInvitation,
            press: () {
              textController.clear();
              BlocProvider.of<DialogCubit>(context).emitDialogInitialState();
              DialogHelper.useInvitationDialog(context, textController);
            },
          ),
          SizedBox(
            height:
                SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar * 0.011,
          )
        ],
      ),
      // color: Colors.amber,
    );
  }
}
