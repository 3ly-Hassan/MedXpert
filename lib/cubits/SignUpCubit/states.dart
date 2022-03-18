import 'package:final_pro/models/signup_model.dart';

abstract class ShopSignUpStates {}

class ShopSignUpInitialState extends ShopSignUpStates {}

class ShopSignUpLoadingState extends ShopSignUpStates {}

class ShopSignUpSuccessState extends ShopSignUpStates {
  final SignUpResponseModel signUpResponseModel;

  ShopSignUpSuccessState(this.signUpResponseModel);
}

class ShopSignUpErrorState extends ShopSignUpStates {
  final String error;

  ShopSignUpErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopSignUpStates {}
