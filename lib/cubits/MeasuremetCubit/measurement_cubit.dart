import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/doctor.dart';
import 'package:final_pro/models/measurement.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'measurement_state.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  APIService api = new APIService();
  List<Measurement> measurements = [];
  List<Measurement> doctorMeasurement = [];
  Patient patient = Patient();
  Doctor doctor = Doctor();
  List<int> expanded = [];
  bool empty = false;
  bool readOnly = true;
  MeasurementCubit() : super(MeasurementInitial());

  static MeasurementCubit get(context) => BlocProvider.of(context);

  // measurements

  List<Measurement> get_measurements() {
    emit(MeasurementLoading());
    _patientMeasurementFromDb().then((measurements) {
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

  Future<List<Measurement>> _patientMeasurementFromDb() async {
    var measurements = await api.get_measurements();

    return measurements.map((m) => Measurement.fromJson(m)).toList();
  }

  List<Measurement> getDoctorMeasurement(String name) {
    emit(MeasurementLoading());
    _doctorMeasurementFromDb(name).then((doctorMeasurement) {
      if (doctorMeasurement.length == 0) {
        empty = true;
        emit(MeasurementEmpty());
        return doctorMeasurement;
      }
      empty = false;
      this.doctorMeasurement = doctorMeasurement;
      emit(MeasurementLoaded(doctorMeasurement));
    });
    print(doctorMeasurement);
    return doctorMeasurement;
  }

  Future<List<Measurement>> _doctorMeasurementFromDb(String name) async {
    var measurements = await api.getDoctorMeasurement(name);

    return measurements.map((m) => Measurement.fromJson(m)).toList();
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

  //patient profile

  void getPatientProfile() {
    emit(GetPatientProfileLoading());
    _getPatientProfile().then((value) {
      if (value == null) {
        return null;
      }
      patient = value;
      genderVal = patient.gender;
      emit(GetPatientProfileLoaded());
    });
  }

  Future<Patient?> _getPatientProfile() async {
    Patient? p = await api.getPatientProfile();
    return p;
  }

  void updatePatientProfile(Patient patient) {
    emit(updatePatientProfileLoading());
    _updatePatient(patient).then((value) {
      if (value == null) {
        return null;
      }
      this.patient = value;
      emit(updatePatientProfileLoaded());
    });
  }

  Future<Patient?> _updatePatient(Patient patient) async {
    Patient? p = await api.updatePatient(patient);
    return p;
  }

  void deletePatient() {
    emit(deletePatientProfileLoading());
    _deletePatient().then((value) {
      emit(deletePatientProfileLoaded());
    });
  }

  Future<void> _deletePatient() async {
    await api.deletePatient();
  }

  //doctor profile

  void getdoctorProfile() {
    emit(GetDoctorProfileLoading());
    _getDoctorProfile().then((value) {
      if (value == null) {
        return null;
      }
      doctor = value;
      emit(GetDoctorProfileLoaded());
    });
  }

  Future<Doctor?> _getDoctorProfile() async {
    Doctor? doc = await api.getDoctorProfile();
    return doc;
  }

  void updateDoctorProfile(Doctor doctor) {
    emit(UpdateDoctorProfileLoading());
    _updateDoctor(doctor).then((value) {
      if (value == null) {
        return null;
      }
      this.doctor = value;
      emit(UpdateDoctorProfileLoaded());
    });
  }

  Future<Doctor?> _updateDoctor(Doctor doctor) async {
    Doctor? doc = await api.updateDoctor(doctor);
    return doc;
  }

  void deleteDoctor() {
    emit(DeleteDoctorProfileLoading());
    _deleteDoctor().then((value) {
      emit(DeleteDoctorProfileLoaded());
    });
  }

  Future<void> _deleteDoctor() async {
    await api.deleteDoctor();
  }

  invertExpand(i) {
    expanded.contains(i) ? expanded.remove(i) : expanded.add(i);
    emit(MeasurementExpanded());
  }

  toggleReadOnly() {
    readOnly = !readOnly;
    emit(ToggleReadOnly());
  }

  String? genderVal;
  genderRadio(value) {
    genderVal = value;
    emit(UpdateGender());
  }
}
