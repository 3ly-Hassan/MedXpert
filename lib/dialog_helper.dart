import 'package:final_pro/cubits/dialog_cubit/dialog_cubit.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'components/loading_row.dart';
import 'constants.dart';

class DialogHelper {
  //ToDo : it is your choice => barrierDismissible: false, // user must tap button!

  static void createInvitationDialog(
    BuildContext context,
  ) {
    BlocProvider.of<DialogCubit>(context).emitDialogLoadingState();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BlocBuilder<DialogCubit, DialogState>(
        builder: (context, state) {
          if (state is DialogLoadingState) {
            return AlertDialog(
              title: Text(kYourInvitationNumber),
              content: LoadingRow(),
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
                    await Share.share(
                      state.invitationNumber!,
                      subject: kYourInvitationNumber,
                    );
                  },
                ),
              ],
            );
          } else if (state is DialogErrorState) {
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
      builder: (context) => BlocBuilder<DialogCubit, DialogState>(
        builder: (context, state) {
          if (state is DialogLoadingState) {
            return AlertDialog(
              title: Text(kUseAnInvitation),
              content: LoadingRow(),
              actions: <Widget>[
                TextButton(
                  child: Text(kCancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(kOk),
                  onPressed: null,
                ),
              ],
            );
          }
          //
          else if (state is DialogErrorState) {
            return AlertDialog(
              title: Text(kAlert),
              content: Text(state.errorMessage),
              actions: <Widget>[
                TextButton(
                  child: Text(kCancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(kOk),
                  onPressed: () {
                    BlocProvider.of<DialogCubit>(context)
                        .emitDialogInitialState();
                  },
                ),
              ],
            );
          }
          return AlertDialog(
            title: Text(kUseAnInvitation),
            content: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: kEnterTheNumber,
                        errorMaxLines: 2,
                      ),
                      controller: textController,
                      validator: _validate,
                      onFieldSubmitted: (_) async {
                        await onPressedOkButton(
                            context, _formKey, textController);
                      },
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
                  await onPressedOkButton(context, _formKey, textController);
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

  static Future<void> onPressedOkButton(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController textController) async {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<DialogCubit>(context).emitDialogLoadingState();
      await BlocProvider.of<TeamsCubit>(context)
          .useInvitationNumber(textController.text, context);
    }
  }
}
