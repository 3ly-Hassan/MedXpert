import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cubits/medication_cubits/medications_list_cubit/medications_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/medication.dart';

part 'drugs_list_state.dart';

class DrugsListCubit extends Cubit<DrugsListState> {
  DrugsListCubit() : super(DrugsListInitial());
  APIService apiService = APIService();

  late Medication medicationItem;
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

    bool isDeleted = await apiService.deleteDrug(medicationId, drugId);

    if (!isDeleted) {
      drugs.insert(index, packUp);
      emit(DeletionFailedState());
    } else {
      await BlocProvider.of<MedicationsListCubit>(context).getMedicationsList();
    }
  }
}
