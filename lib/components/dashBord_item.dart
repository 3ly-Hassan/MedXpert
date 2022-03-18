import 'package:flutter/material.dart';

import '../constants.dart';

class DashBordItem extends StatelessWidget {
  final String? image;
  final String? title;
  final Function? onPress;
  final Color? color;
  const DashBordItem({
    @required this.image,
    @required this.title,
    this.onPress,
    this.color = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress as void Function(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                image!,
                fit: BoxFit.fill,
                height: 98,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: color,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
