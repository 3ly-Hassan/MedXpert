import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
    fontSize: kSpacingUnit * 1.7,
    fontWeight: FontWeight.w600,
    color: Colors.amberAccent);

final kCaptionTextStyle = TextStyle(
  fontSize: kSpacingUnit * 1.3,
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: kSpacingUnit * 1.5,
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);