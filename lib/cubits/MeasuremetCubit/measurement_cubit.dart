import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:meta/meta.dart';

part 'measurement_state.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  APIService api = new APIService();
  List<Measurement> measurements = [];
  MeasurementCubit() : super(MeasurementInitial());

   Future<List<Measurement>> _measurement_from_db()async {
     var measurements=  await api.get_measurements();
     return measurements.map((m) => Measurement.fromJson(m)).toList();
   }

  Future<List<Measurement>> get_measurements()async {
    _measurement_from_db().then((measurements) {
    print(measurements);
   emit(MeasurementLoaded(measurements));
    this.measurements = measurements;
    } );
    
  
    return measurements;
  }
}
