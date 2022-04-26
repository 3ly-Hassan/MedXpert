part of 'medication_cubit.dart';

@immutable
abstract class MedicationState {}

class MedicationInitial extends MedicationState {}

class GetPatientListState extends MedicationState {
  final List patientList;
  GetPatientListState(this.patientList);
}

class MedicationLoadingState extends MedicationState {}
