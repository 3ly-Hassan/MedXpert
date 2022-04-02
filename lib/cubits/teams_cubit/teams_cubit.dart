import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/models/patient.dart';

import '../../constants.dart';
import '../../models/doctor.dart';
import '../../models/invitation.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  List<Follower> patientFollowers = [];
  List<Follower> patientFollowings = [];
  List<Follower> doctorFollowings = [];
  Patient? patientModel;
  Doctor? doctorModel;

  bool isFollowersSelected = true;

  TeamsCubit() : super(TeamsInitialState());
  APIService apiService = APIService();

  void emitTeamsInitialState() {
    emit(TeamsInitialState());
  }

  void emitTeamsLoadingState() {
    emit(TeamsLoadingState());
  }

//   void emitGetFollowingInfoState{
//     emit(GetFollowingState(model))
// }
  void selectFollowers() {
    isFollowersSelected = true;
    emit(GetFollowingState(patientModel));
  }

  void selectFollowings() {
    isFollowersSelected = false;
    emit(GetFollowingState(patientModel));
  }

  Future getFollowingInfo() async {
    emit(TeamsLoadingState());
    if (role == "patient") {
      print('I am a patient !!!!!!!!!');
      patientModel = await apiService.getPatientProfile();
      // patientModel=Patient(gender: "male", email: "ssdhs@gmail.com", followers: [
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      // ], followings: [
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      // ]);
      emit(GetFollowingState(patientModel));
    } else {
      print('I am a doctor !!!!!!!!!');
      doctorModel = await apiService.getDoctorProfile();
      emit(GetFollowingState(doctorModel));
    }
  }

  Future<void> createInvitationEvent() async {
    // await Future.delayed(Duration(seconds: 3));
    final invitationModel = await apiService.createInvitation();
    emit(InvitationCreationState(
        invitationNumber: invitationModel?.invitaionNumber));
  }

  Future<Object?> useInvitationEvent(String text) async {
    if (role == "patient") {
      print('patient!!!!!!!!!');
      final InvitationResponseModel response =
          await apiService.useInvitationPatient(text);
      if (response.msg != kServerError) {
        if (patientFollowers.isEmpty || patientFollowings.isEmpty) {
          final patientModel = await apiService.getPatientProfile();
          return patientModel;
        }
      } else {
        return null;
      }
    } else {
      print('Doctor!!!!!!!!!');
      final InvitationResponseModel response =
          await apiService.useInvitationDoctor(text);
      if (response.msg != kServerError) {
        if (doctorFollowings.isEmpty) {
          final doctorModel = await apiService.getDoctorProfile();
          return doctorModel;
        }
      } else {
        return null;
      }
    }
  }
}
