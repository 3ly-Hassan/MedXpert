import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'constants.dart';
import 'models/invitation.dart';

class DialogHelper {
  //ToDo : it is your choice => barrierDismissible: false, // user must tap button!

  static void createInvitationDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          if (state is TeamsLoadingState) {
            return AlertDialog(
              title: Text(kYourInvitationNumber),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(kLoading),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (state is InvitationCreationState) {
            return AlertDialog(
              title: Text(kYourInvitationNumber),
              content: GestureDetector(
                onTap: () async {
                  await copyAction(state.invitationNumber!);
                },
                child: Row(
                  children: [
                    Text(
                      state.invitationNumber!,
                      style: TextStyle(
                        background: Paint()
                          ..color = kPrimaryColor.withAlpha(
                            100,
                          ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () async {
                        await copyAction(state.invitationNumber!);
                      },
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(kCancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(kShare),
                  onPressed: () async {
                    await Share.share(state.invitationNumber!,
                        subject: kYourInvitationNumber);
                  },
                ),
              ],
            );
          } else if (state is TeamsErrorState) {
            return AlertDialog(
              title: Text(kYourInvitationNumber),
              content: Text(state.errorMessage),
              actions: [
                TextButton(
                  child: Text(kOk),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  static void useInvitationDialog(
    BuildContext context,
    TextEditingController textController,
  ) {
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          return AlertDialog(
            title: Text(kUseAnInvitation),
            content: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: kEnterTheNumber,
                        errorMaxLines: 2,
                      ),
                      controller: textController,
                      validator: _validate,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.paste),
                  onPressed: () async {
                    final pasteResult = await pasteAction();
                    textController.text = pasteResult!;
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(kCancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(kOk),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final APIService apiService = APIService();
                    final InvitationResponseModel response = await apiService
                        .useInvitationPatient(textController.text);

                    print('the error: ${response.msg}');

                    //TODO take your action
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  static Future<void> copyAction(String copiedText) async {
    await Clipboard.setData(ClipboardData(text: copiedText));
    await showCentralToast(text: kCopied, state: ToastStates.SUCCESS);
  }

  static Future<String?> pasteAction() async {
    ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData != null ? clipboardData.text : null;
  }

  static String? _validate(value) {
    if (value == null || value.isEmpty) {
      return kPleaseEnterANumber;
    } else if (!isNumber(value)) {
      return kOnlyNumbersAreAllowed;
    }
    return null;
  }

  static bool isNumber(String text) {
    final result = int.tryParse(text);
    if (result == null) {
      return false;
    } else {
      return true;
    }
  }
}
