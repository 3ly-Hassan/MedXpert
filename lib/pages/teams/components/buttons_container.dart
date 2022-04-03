import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../cubits/dialog_cubit/dialog_cubit.dart';
import '../../../dialog_helper.dart';
import '../../../size_config.dart';

class ButtonsContainer extends StatefulWidget {
  const ButtonsContainer({Key? key}) : super(key: key);

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
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          DefaultButton(
            text: kCreateInvitation,
            press: () async {
              //show dialog at first, then call the method for creating invitation number
              DialogHelper.createInvitationDialog(context);
              await BlocProvider.of<DialogCubit>(context)
                  .createInvitationEvent();
            },
          ),
          Spacer(),
          DefaultButton(
            text: kUseInvitation,
            press: () {
              textController.clear();
              BlocProvider.of<DialogCubit>(context).emitDialogInitialState();
              DialogHelper.useInvitationDialog(context, textController);
            },
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
      height: SizeConfig.screenHeight * 0.18,
      // color: Colors.amber,
    );
  }
}
