import 'package:final_pro/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubits/MeasuremetCubit/measurement_cubit.dart';
import 'cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';
import 'models/medication.dart';

const kPrimaryColor = Color(0xFF10de62);
const kPrimaryColorLight = Color(4291356361);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
final kErrorColor = Colors.red[700];

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: (28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

//---------Teams---------//
const String kCreateInvitation = "Create invitation";
const String kUseInvitation = "Use invitation";
const String kYourInvitationNumber = "Your Invitation Number";
const String kCopy = "Copy";
const String kCopied = "Copied!";
const String kCancel = "Cancel";
const String kFollowers = "Followers";
const String kFollowings = "Followings";
const String kShare = "Share";
const List dropDownValues = [kFollowers, kFollowings];
const String kShareMessage = 'Enter your share message !';
const String kOk = 'Ok';
const String kLoading = 'Loading...';
const String kUseAnInvitation = 'Use an invitation';
const String kEnterTheNumber = 'Your number';
const String kPleaseEnterANumber = 'Please enter a number!';
const String kOnlyNumbersAreAllowed = 'Only numbers are allowed!';
const String kServerError = "server error";
const String kAlert = "Alert!";
const String kSorryForThat =
    "Sorry for that, but something went wrong, please try again";
const String kSuccessMessageFromDataBase = 'success';
const String kNoFollowersYet = 'No followers yet';
const String kNoFollowingsYet = 'No followings yet';
const String kAreYouSure = 'Are you sure?';
const String kYes = 'yes';
const String kNo = 'No';
const String kSnooze = 'Snooze (5 min)';
const String kUnFollow = 'Un-follow';
const String kDone = 'Done!';
const String KDeletedDone = 'Deleted done!';
const String KDeletedFailed = 'Deleted failed!';
const int kNoFollowersAnimationDuration = 500;
const double kContainerOfTeamsListRatioForPatients = 0.78;
const double kContainerOfTeamsListRatioForDoctors = 0.86;
const double kContainerOfTeamsButtonsRatioForPatients = 0.22;
const double kContainerOfTeamsButtonsRatioForDoctors = 0.135;
const double kContainerOfMedicationCreationButton = 0.135;
const double kContainerOfCreateMedicationListRatio = 0.94;
const String kFormattedString = 'yyyy-MM-dd';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

String? token;
String? role;
List<String> specializations = [];
var splash = true;
void showToast({
  @required String? text,
  @required ToastStates? state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0,
    );

Future<void> showCentralToast({
  @required String? text,
  @required ToastStates? state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

bool checkAuthorizationInDrugsListScreen(BuildContext context) {
  if (role == 'patient') {
    return BlocProvider.of<DrugsListCubit>(context).medicationItem.doctorId ==
        null;
  } else {
    return false;
  }
}

bool checkAuthorizationInMedicationsListScreen(
    BuildContext context, Medication medication) {
  if (role == 'patient') {
    return medication.doctorId == null;
  } else {
    return medication.doctorId == MeasurementCubit.get(context).doctor.id;
  }
}
