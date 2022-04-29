import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';

import '../../../models/doctor.dart';

part 'meddication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(MedicationInitial());
  APIService apiService = APIService();

  List patientList = [];

  void emitLoadingState() {
    emit(MedicationLoadingState());
  }

  Future<void> getPatientList() async {
    emit(MedicationLoadingState());
    final Doctor? doctorModel = await apiService.getDoctorProfile();
    patientList = doctorModel!.followings!;
    emit(GetPatientListState(patientList));
  }
}
