part of 'teams_patient_cubit.dart';

@immutable
abstract class TeamsPatientState {}

class TeamsPatientInitial extends TeamsPatientState {}

class TeamsPatientLoadingState extends TeamsPatientState {}

class TeamsPatientErrorState extends TeamsPatientState {}

class Expanded extends TeamsPatientState {}

class GetPatientInfoState extends TeamsPatientState {
  final List<Measurement> measurements;
  final List<Chronics> chronics;
  GetPatientInfoState({
    required this.measurements,
    required this.chronics,
  });
}
