import 'package:final_pro/models/signup_model.dart';

abstract class MedSignUpStates {}

class MedSignUpInitialState extends MedSignUpStates {}

class MedSignUpLoadingState extends MedSignUpStates {}

class MedSignUpSuccessState extends MedSignUpStates {
  final SignUpResponseModel signUpResponseModel;

  MedSignUpSuccessState(this.signUpResponseModel);
}

class MedSignUpErrorState extends MedSignUpStates {
  final String error;

  MedSignUpErrorState(this.error);
}

class MedChangePasswordVisibilityState extends MedSignUpStates {}
