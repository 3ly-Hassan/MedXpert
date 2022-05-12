part of 'medications_list_cubit.dart';

@immutable
abstract class MedicationsListState {}

class MedicationsListInitial extends MedicationsListState {}

class MedicationsListLoadingState extends MedicationsListState {}

class GetMedicationsListState extends MedicationsListState {
  final List medicationsList;
  GetMedicationsListState(this.medicationsList);
}

class DeleteFailedState extends MedicationsListState {
  final List medicationsList;
  DeleteFailedState(this.medicationsList);
}
