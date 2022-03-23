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

  void createMeasurement(Measurement measurement) {
    emit(CreatedLoading());
    _createMeasurement(measurement).then((v) {
      if (v == null) {
        return;
      }
      empty = false;
      if (measurements.length == 5) {
        print('ss');
        measurements.removeLast();
      }
      print('ss');
      measurements.insert(0, v);
      emit(CreatedLoaded());
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<Measurement?> _createMeasurement(Measurement measurement) async {
    Measurement? v = await api.createMeasurement(measurement);
    return v;
  }

  void deleteMeasurement(String id) {
    emit(DeletedLoading());
    _deleteMeasurement(id).then((_) {
      measurements.removeWhere((obj) => obj.id == id);
      emit(DeletedLoaded());
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> _deleteMeasurement(String id) async {
    await api.deleteMeasurement(id);
  }

  invertExpand(i) {
    expanded.contains(i) ? expanded.remove(i) : expanded.add(i);
    emit(MeasurementExpanded());
  }
}
