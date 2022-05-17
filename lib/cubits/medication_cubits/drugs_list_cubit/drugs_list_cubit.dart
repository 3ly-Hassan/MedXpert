import 'package:final_pro/api_service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/medication.dart';
import '../../../models/medication_drug.dart';
import '../medications_list_cubit/medications_list_cubit.dart';

part 'drugs_list_state.dart';

class DrugsListCubit extends Cubit<DrugsListState> {
  DrugsListCubit() : super(DrugsListInitial());
  APIService apiService = APIService();

  bool isDeleted = false;
  Medication medicationItem = Medication();
  List drugs = [];

  getDrugsList(Medication medication) {
    medicationItem = medication;
    drugs = medicationItem.drugs!;
    emit(GetDrugsListState(drugs));
  }

  Future deleteDrug(String medicationId, String drugId, int index,
      BuildContext context) async {
    final packUp = drugs[index];
    drugs.removeAt(index);
    emit(GetDrugsListState(drugs));

    isDeleted = await apiService.deleteDrug(medicationId, drugId);

    if (!isDeleted) {
      drugs.insert(index, packUp);
      emit(DeletionFailedState());
    }
  }

  Future addDrugToMedication(
      String medicationId, MedicationDrug drug, BuildContext context) async {
    emit(DrugsListLoadingState());
    Medication? receivedMedication =
        await apiService.addDrugToMedication(medicationId, drug);

    if (receivedMedication != null) {
      medicationItem = receivedMedication;
      drugs = medicationItem.drugs!;

      //refresh drugs list
      emit(AddingDrugSuccessState(receivedMedication.drugs!));
      Navigator.of(context).pop();
      //refresh medication list with new added drug
      BlocProvider.of<MedicationsListCubit>(context).getMedicationsList();
    } else {
      emit(AddingDrugFailedState());
    }
  }

  Future toggleSwitch(
      context, bool value, String medicationId, String drugId) async {
    Medication? medication =
        await apiService.updateCurrentlyTaken(value, medicationId, drugId);
    if (medication != null) {
      getDrugsList(medication);
      //refresh medications_list_screen
      BlocProvider.of<MedicationsListCubit>(context).getMedicationsList();
    } else {
      emit(UpdateDrugFailedState());
    }
  }
}
