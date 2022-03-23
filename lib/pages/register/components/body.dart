import 'package:final_pro/components/social_card.dart';
import 'package:final_pro/pages/register/components/sign_up_form.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: (20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04), // 4%
                Text("Register Account", style: headingStyle),
                Text(
                  "Complete your details",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SignUpForm(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SizedBox(height: (20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
