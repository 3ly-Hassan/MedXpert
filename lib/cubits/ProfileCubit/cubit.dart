import 'package:final_pro/cubits/ProfileCubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/api_service.dart';
import '../../models/patient.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  Patient? patient = null;
  APIService api = new APIService();
  getPatientFRomDb() async {
    Patient? p = await api.getProfile();
    if (p != null) {
      patient = p;
      emit(GetProfileState());
    } else {
      patient = null;
    }
  }
}
