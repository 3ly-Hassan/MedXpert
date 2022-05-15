part of 'create_medication_cubit.dart';

@immutable
abstract class CreateMedicationState {}

class CreateMedicationInitial extends CreateMedicationState {}

class ShowSearchListState extends CreateMedicationState {
  final List searchList;
  ShowSearchListState(this.searchList);
}

class CreateMedicationLoadingState extends CreateMedicationState {}

class CreateMedicationSuccess extends CreateMedicationState {}

class CreateMedicationFailed extends CreateMedicationState {}

class GetMedicationState extends CreateMedicationState {}
