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

  MeasurementCubit() : super(MeasurementInitial());

  static MeasurementCubit get(context) => BlocProvider.of(context);

  Future<List<Measurement>> _measurement_from_db() async {
    var measurements = await api.get_measurements();
    return measurements.map((m) => Measurement.fromJson(m)).toList();
  }

  List<Measurement> get_measurements() {
    emit(MeasurementLoading());
    _measurement_from_db().then((measurements) {
      emit(MeasurementLoaded());
      this.measurements = measurements;
    });

    return measurements;
  }
}
