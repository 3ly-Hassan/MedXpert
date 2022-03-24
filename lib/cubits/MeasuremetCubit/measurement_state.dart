part of 'measurement_cubit.dart';

@immutable
abstract class MeasurementState {}

class MeasurementInitial extends MeasurementState {}

class MeasurementLoading extends MeasurementState {}

class MeasurementError extends MeasurementState {}

class MeasurementLoaded extends MeasurementState {
  final List<Measurement> measurements;

  MeasurementLoaded(this.measurements);
}

class MeasurementExpanded extends MeasurementState {}

class MeasurementEmpty extends MeasurementState {}

class CreatedLoading extends MeasurementState {}

class CreatedLoaded extends MeasurementState {}

class CreatedFailed extends MeasurementState {}

class DeletedLoading extends MeasurementState {}

class DeletedLoaded extends MeasurementState {}

class GetPatientProfileLoading extends MeasurementState {}

class GetPatientProfileLoaded extends MeasurementState {}

class updatePatientProfileLoading extends MeasurementState {}

class updatePatientProfileLoaded extends MeasurementState {}

class deletePatientProfileLoading extends MeasurementState {}

class deletePatientProfileLoaded extends MeasurementState {}

class GetDoctorProfileLoading extends MeasurementState {}

class GetDoctorProfileLoaded extends MeasurementState {}

class UpdateDoctorProfileLoading extends MeasurementState {}

class UpdateDoctorProfileLoaded extends MeasurementState {}

class DeleteDoctorProfileLoading extends MeasurementState {}

class DeleteDoctorProfileLoaded extends MeasurementState {}

class ToggleReadOnly extends MeasurementState {}
