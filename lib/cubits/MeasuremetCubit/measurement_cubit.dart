import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'measurement_state.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  APIService api = new APIService();
  List<Measurement> measurements = [];
  List<int> expanded = [];
  bool empty = false;
  MeasurementCubit() : super(MeasurementInitial());

  static MeasurementCubit get(context) => BlocProvider.of(context);

  Future<List<Measurement>> _measurement_from_db() async {
    var measurements = await api.get_measurements();

    return measurements.map((m) => Measurement.fromJson(m)).toList();
  }

  List<Measurement> get_measurements() {
    emit(MeasurementLoading());
    _measurement_from_db().then((measurements) {
      if (measurements.length == 0) {
        empty = true;
        emit(MeasurementEmpty());
        return measurements;
      }
      empty = false;
      this.measurements = measurements;
      emit(MeasurementLoaded(measurements));
    });
    print(measurements);
    return measurements;
  }

  List<Measurement> createMeasurement(Measurement measurement) {
    _createMeasurement(measurement);
    return get_measurements();
  }

  _createMeasurement(Measurement measurement) async {
    Measurement? _ = await api.createMeasurement(measurement);
  }

  List<Measurement> deleteMeasurement(String id) {
    _deleteMeasurement(id);
    return get_measurements();
  }

  _deleteMeasurement(String id) async {
    await api.deleteMeasurement(id);
  }

  invertExpand(i) {
    expanded.contains(i) ? expanded.remove(i) : expanded.add(i);
    emit(MeasurementExpanded());
  }
}
