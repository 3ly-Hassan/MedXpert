part of 'teams_doctor_cubit.dart';

@immutable
abstract class TeamsDoctorState {}

class TeamsDoctorInitial extends TeamsDoctorState {}

class TeamsDoctorLoadingState extends TeamsDoctorState {}

class TeamsDoctorErrorState extends TeamsDoctorState {}

class GetDoctorInfoState extends TeamsDoctorState {
  final Doctor doctor;
  GetDoctorInfoState(this.doctor);
}
