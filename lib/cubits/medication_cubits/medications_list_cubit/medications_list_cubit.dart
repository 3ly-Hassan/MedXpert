import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:meta/meta.dart';

part 'medications_list_state.dart';

class MedicationsListCubit extends Cubit<MedicationsListState> {
  MedicationsListCubit() : super(MedicationsListInitial());
  APIService apiService = APIService();
  List medicationsList = [];

  Future getMedicationsList(String followerId) async {
    emit(MedicationsListLoadingState());
    medicationsList = (await apiService.getMedicationsList(followerId))!;
    emit(GetMedicationsListState(medicationsList));
  }

  Future deleteMedication(String medicationId, int index) async {
    final packUp = medicationsList[index];
    medicationsList.removeAt(index);
    emit(GetMedicationsListState(medicationsList));

    bool isDeleted = await apiService.deleteMedication(medicationId);

    if (!isDeleted) {
      medicationsList.insert(index, packUp);
      emit(DeleteFailedState(medicationsList));
    }
  }
}
