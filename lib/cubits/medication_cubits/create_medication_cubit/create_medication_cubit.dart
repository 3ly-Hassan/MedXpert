import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/medication_drug.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/min_drug_model.dart';

part 'create_medication_state.dart';

class CreateMedicationCubit extends Cubit<CreateMedicationState> {
  CreateMedicationCubit() : super(CreateMedicationInitial());

  APIService apiService = APIService();

  int indexController = -1; //to be 0 if addNewMedication called

  List<MinDrugModel> selectedSuggestion = [];

  List<TextEditingController> drugTextControllerList = [];
  List<TextEditingController> doseTextControllerList = [];
  List<TextEditingController> startDateTextControllerList = [];
  List<TextEditingController> endDateTextControllerList = [];

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

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
          drugId: selectedSuggestion[i].drugId,
          drugName: selectedSuggestion[i].drugName,
          dose: int.parse(doseTextControllerList[i].text),
          startDate: startDateTextControllerList[i].text,
          endDate: endDateTextControllerList[i].text,
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
    emit(CreateMedicationLoadingState());
  }

  Future<List?> searchForDrug(String searchKey) async {
    final drugList = await apiService.searchForDrug(searchKey);
    return drugList;
  }

  Future createMedication(
      String? patientId, String medicationName, BuildContext context) async {
    final bool validator1 = formKey1.currentState!.validate();
    final bool validator2 = formKey2.currentState!.validate();
    if (validator1 && validator2) {
      emitLoadingState();
      List medicationList = collectMedicationList();
      bool isCreated = await apiService.createMedication(
          patientId, medicationName, medicationList);

      if (isCreated) {
        Navigator.of(context).pop();
        emit(CreateMedicationSuccess());
        print('Create Medication is valid and has been done!');
      } else {
        emit(CreateMedicationFailed());
      }
    }
  }
}
