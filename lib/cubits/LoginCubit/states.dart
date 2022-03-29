import 'package:final_pro/models/login_model.dart';

abstract class MedLoginStates {}

class MedLoginInitialState extends MedLoginStates {}

class MedLoginLoadingState extends MedLoginStates {}

class MedLoginSuccessState extends MedLoginStates {
  final LoginResponseModel loginModel;

  MedLoginSuccessState(this.loginModel);
}

class MedLoginErrorState extends MedLoginStates {
  final String error;

  MedLoginErrorState(this.error);
}

class RoleState extends MedLoginStates {}

class SelectState extends MedLoginStates {}

class MedChangePasswordVisibilityState extends MedLoginStates {}
