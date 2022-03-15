import 'package:flutter/material.dart';

import '../constants.dart';

class DashBordItem extends StatelessWidget {
  final String? image;
  final String? title;
  final Function? onPress;
  const DashBordItem({
    @required this.image,
    @required this.title,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress as void Function(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image!,
              height: 98,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: kPrimaryColor,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
