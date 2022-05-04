part of 'create_medication_cubit.dart';

@immutable
abstract class CreateMedicationState {}

class MedicationDetailsInitial extends CreateMedicationState {}

class MedicationDetailsLoadingState extends CreateMedicationState {}

class ShowSearchListState extends CreateMedicationState {
  final List searchList;
  ShowSearchListState(this.searchList);
}

class GetMedicationState extends CreateMedicationState {}
