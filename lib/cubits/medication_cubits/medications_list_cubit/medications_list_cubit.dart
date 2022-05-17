import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cubits/medication_cubits/medication_cubit/medication_cubit.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';
import '../../../models/doctor.dart';
import '../../../models/patient.dart';

part 'medications_list_state.dart';

class MedicationsListCubit extends Cubit<MedicationsListState> {
  MedicationsListCubit() : super(MedicationsListInitial());
  APIService apiService = APIService();

  late String followerId;
  List medicationsList = [];

  Future getMedicationsList() async {
    emit(MedicationsListLoadingState());
    if (role == 'patient') {
      medicationsList = (await apiService.getMedicationsList())!;
      emit(GetMedicationsListState(medicationsList));
    }
    //if doctor
    else {
      medicationsList = (await apiService.getMedicationsList(followerId))!;
      emit(GetMedicationsListState(medicationsList));
      //
    }
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
