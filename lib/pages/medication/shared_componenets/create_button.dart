import 'package:flutter/material.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CreateButton extends StatelessWidget {
  final Function onPress;
  const CreateButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeightUnderAppAndStatusBarAndTabBar *
          kContainerOfMedicationCreationButton,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultButton(
            text: 'Create',
            press: () async {
              onPress();
            },
          ),
        ],
      ),
    );
  }
}
