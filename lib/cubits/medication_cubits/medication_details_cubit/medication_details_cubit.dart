import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/medication_drug.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../models/min_drug_model.dart';

part 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitial());

  APIService apiService = APIService();

  int indexController = -1; //to be 0 if addNewMedication called

  List<MinDrugModel> selectedSuggestion = [];

  List<TextEditingController> drugTextControllerList = [];
  List<TextEditingController> doseTextControllerList = [];
  List<TextEditingController> startDateTextControllerList = [];
  List<TextEditingController> endDateTextControllerList = [];

  void dispose() {
    // drugTextControllerList.forEach((element) => element.dispose());
    // doseTextControllerList.forEach((element) => element.dispose());
    // startDateTextControllerList.forEach((element) => element.dispose());
    // endDateTextControllerList.forEach((element) => element.dispose());
    //
    indexController = -1;
    selectedSuggestion.clear();
    drugTextControllerList.clear();
    doseTextControllerList.clear();
    startDateTextControllerList.clear();
    endDateTextControllerList.clear();
  }

  List collectMedicationList() {
    List medicationList = [];
    for (int i = 0; i <= indexController; i++) {
      medicationList.add(
        MedicationDrug(
          selectedSuggestion[i].drugId,
          selectedSuggestion[i].drugName,
          int.parse(doseTextControllerList[i].text),
          startDateTextControllerList[i].text,
          endDateTextControllerList[i].text,
        ).toJson(),
      );
    }
    return medicationList;
  }

  void addNewMedicationItem() {
    indexController = indexController + 1;
    selectedSuggestion.add(MinDrugModel());
    drugTextControllerList.add(TextEditingController());
    doseTextControllerList.add(TextEditingController());
    startDateTextControllerList.add(TextEditingController());
    endDateTextControllerList.add(TextEditingController());
    emit(GetMedicationState());
  }

  void removeMedicationItem(int index) {
    indexController = indexController - 1;
    selectedSuggestion.removeAt(index);
    drugTextControllerList.removeAt(index);
    doseTextControllerList.removeAt(index);
    startDateTextControllerList.removeAt(index);
    endDateTextControllerList.removeAt(index);
    emit(GetMedicationState());
  }

  void emitLoadingState() {
    emit(MedicationDetailsLoadingState());
  }

  Future<List?> searchForDrug(String searchKey) async {
    final drugList = await apiService.searchForDrug(searchKey);
    return drugList;
  }

  Future createMedication(String patientId, List drugMedicationList) async {
    // emitLoadingState();
    await apiService.createMedication(patientId, drugMedicationList);
  }
}
