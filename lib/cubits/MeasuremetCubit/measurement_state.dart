part of 'measurement_cubit.dart';

@immutable
abstract class MeasurementState {}

class MeasurementInitial extends MeasurementState {}

class MeasurementLoaded extends MeasurementState {
  final List<Measurement> measurements;
  MeasurementLoaded(this.measurements);

}
