import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../api_service/api_service.dart';
import '../../../models/doctor.dart';

part 'teams_doctor_state.dart';

class TeamsDoctorCubit extends Cubit<TeamsDoctorState> {
  TeamsDoctorCubit() : super(TeamsDoctorInitial());
  APIService apiService = APIService();

  Future getDoctorInfo(String doctorId) async {
    emit(TeamsDoctorLoadingState());
    Doctor? doctor = await apiService.getDoctorProfileById(doctorId);
    if (doctor == null) {
      emit(TeamsDoctorErrorState());
    } else {
      emit(GetDoctorInfoState(doctor));
    }
  }
}
