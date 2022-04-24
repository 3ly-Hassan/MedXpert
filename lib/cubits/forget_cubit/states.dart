import 'package:final_pro/models/signup_model.dart';

abstract class ForgetStates {}

class InitialState extends ForgetStates {}

class ForgetPassSuccess extends ForgetStates {
  final ForgetPassResponseModel model;

  ForgetPassSuccess(this.model);
}

class ForgetPassLoading extends ForgetStates {}

class ChooseTypePass extends ForgetStates {}
