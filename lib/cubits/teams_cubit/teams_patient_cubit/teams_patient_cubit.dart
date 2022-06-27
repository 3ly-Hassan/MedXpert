import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'teams_patient_state.dart';

class TeamsPatientCubit extends Cubit<TeamsPatientState> {
  TeamsPatientCubit() : super(TeamsPatientInitial());
}
