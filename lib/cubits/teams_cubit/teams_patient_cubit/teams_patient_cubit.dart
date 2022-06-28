import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:meta/meta.dart';

import '../../../models/patient.dart';

part 'teams_patient_state.dart';

class TeamsPatientCubit extends Cubit<TeamsPatientState> {
  TeamsPatientCubit() : super(TeamsPatientInitial());
  APIService apiService = APIService();

  Future getPatientInfo(String id) async {
    emit(TeamsPatientLoadingState());
    //
    Patient? patient = await apiService.getPatientProfileById(id);
    List<Measurement>? measurements =
        await apiService.getPatientMeasurementsById(id);
    if (patient != null && measurements != null) {
      emit(
        GetPatientInfoState(
            measurements: measurements, chronics: patient.chronics!),
      );
    } else {
      emit(TeamsPatientErrorState());
    }
  }
}
