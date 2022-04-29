part of 'medication_cubit.dart';

abstract class MedicationState {}

class MedicationInitial extends MedicationState {}

class GetPatientListState extends MedicationState {
  final List patientList;
  GetPatientListState(this.patientList);
}

class MedicationLoadingState extends MedicationState {}
