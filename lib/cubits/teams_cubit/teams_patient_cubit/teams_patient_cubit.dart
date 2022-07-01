import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:meta/meta.dart';

import '../../../models/patient.dart';

part 'teams_patient_state.dart';

class TeamsPatientCubit extends Cubit<TeamsPatientState> {
  TeamsPatientCubit() : super(TeamsPatientInitial());
  APIService apiService = APIService();
  List<Measurement>? measurements;
  List<Chronics>? chronics;
  Future getPatientInfo(String id) async {
    emit(TeamsPatientLoadingState());
    //
    Patient? patient = await apiService.getPatientProfileById(id);
    measurements = await apiService.getPatientMeasurementsById(id);
    if (patient != null && measurements != null) {
      chronics = patient.chronics;
      emit(
        GetPatientInfoState(measurements: measurements!, chronics: chronics!),
      );
    } else {
      emit(TeamsPatientErrorState());
    }
  }

  List<int> expanded = [];
  invertExpand(i) {
    expanded.contains(i) ? expanded.remove(i) : expanded.add(i);
    emit(Expanded());
  }
}
