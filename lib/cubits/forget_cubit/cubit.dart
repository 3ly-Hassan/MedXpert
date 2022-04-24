import 'package:final_pro/cubits/SignUpCubit/states.dart';
import 'package:final_pro/cubits/forget_cubit/states.dart';
import 'package:final_pro/models/signup_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/api_service.dart';

class ForgetCubit extends Cubit<ForgetStates> {
  ForgetCubit() : super(InitialState());

  static ForgetCubit get(context) => BlocProvider.of(context);
  APIService api = new APIService();

  Future<void> forgetPass(ForgetPassRequestModel requestModel) async {
    emit(ForgetPassLoading());
    _forgetPass(requestModel).then((value) {
      emit(ForgetPassSuccess(value));
    });
  }

  Future<ForgetPassResponseModel> _forgetPass(
      ForgetPassRequestModel requestModel) async {
    ForgetPassResponseModel model = await api.forgetPass(requestModel);
    return model;
  }

  String typeValForPass = '1';
  typeRadioPass(value) {
    typeValForPass = value;
    emit(ChooseTypePass());
  }
}
