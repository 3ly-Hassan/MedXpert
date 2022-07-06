import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';

class YesOrNoTextButton extends StatelessWidget {
  const YesOrNoTextButton({
    Key? key,
    required this.isYesButton,
    required this.index,
    required this.medicationId,
    required this.drugUniqueId,
  }) : super(key: key);
  final bool isYesButton;
  final int index;
  final String medicationId;
  final String drugUniqueId;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        isYesButton ? kYes : kNo,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
          color: isYesButton ? Colors.green : kErrorColor,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () async {
        await BlocProvider.of<DrugsListCubit>(context).isHelpfulDrug(
          context,
          index,
          isYesButton ? true : false,
          medicationId,
          drugUniqueId,
        );
      },
    );
  }
}
