import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/medication_drug.dart';
import 'package:meta/meta.dart';

part 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitial());

  APIService apiService = APIService();

  void emitLoadingState() {
    emit(MedicationDetailsLoadingState());
  }

  Future<List?> searchForDrug(String searchKey) async {
    final drugList = await apiService.searchForDrug(searchKey);
    return drugList;
  }

  Future createMedication(
      String patientId, List drugMedicationList) async {
    // emitLoadingState();
    await apiService.createMedication(patientId, drugMedicationList);
  }
}
