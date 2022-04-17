import 'package:bloc/bloc.dart';
import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/cubits/dialog_cubit/dialog_cubit.dart';
import 'package:final_pro/models/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/doctor.dart';
import '../../models/invitation.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(TeamsInitialState());

  APIService apiService = APIService();

  List<Follower> patientFollowers = [];
  List<Follower> patientFollowings = [];
  List<Follower> doctorFollowings = [];
  Patient? patientModel;
  Doctor? doctorModel;

  bool isFollowersSelected = true;

  void selectFollowers() {
    isFollowersSelected = true;
    emit(GetFollowingStateNoToast(patientModel));
  }

  void selectFollowings() {
    isFollowersSelected = false;
    emit(GetFollowingStateNoToast(patientModel));
  }

  Future getFollowingInfo() async {
    emit(TeamsLoadingState());
    if (role == "patient") {
      print('I am a patient !!!!!!!!!');
      patientModel = await apiService.getPatientProfile();
      // patientModel =
      //     Patient(gender: "male", email: "ssdhs@gmail.com", followers: [
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      //   Follower(email: "email 1", username: 'username 1'),
      //   Follower(email: "email 2", username: 'username 2'),
      // ], followings: [
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      //   Follower(email: "email 3", username: 'username 3'),
      //   Follower(email: "email 4", username: 'username 4'),
      // ]);
      emit(GetFollowingStateNoToast(patientModel));
    } else {
      print('I am a doctor !!!!!!!!!');
      doctorModel = await apiService.getDoctorProfile();
      emit(GetFollowingStateNoToast(doctorModel));
    }
  }

  Future useInvitationNumber(String text, BuildContext context) async {
    //TODO: using context here is anti pattern !!
    if (role == "patient") {
      final InvitationResponseModel response =
          await apiService.useInvitationPatient(text);
      if (response.msg == kSuccessMessageFromDataBase) {
        //TODO: to refresh it locally instead of calling getPatientProfile i need to know the followings info
        //(the follower model itself) to add it
        patientModel = await apiService.getPatientProfile();
        emit(GetFollowingStateWithToast(patientModel));
        Navigator.of(context).pop();
      } else {
        BlocProvider.of<DialogCubit>(context)
            .emitDialogErrorState(response.msg!);
      }
    }
    //in case of doctor
    else {
      print('Doctor!!!!!!!!!');
      final InvitationResponseModel response =
          await apiService.useInvitationDoctor(text);
      if (response.msg != kSuccessMessageFromDataBase) {
        //TODO: to refresh it locally instead of calling getPatientProfile i need to know the followings info
        //(the follower model itself) to add it
        doctorModel = await apiService.getDoctorProfile();
        emit(GetFollowingStateWithToast(doctorModel));
        Navigator.of(context).pop();
      } else {
        BlocProvider.of<DialogCubit>(context)
            .emitDialogErrorState(response.msg!);
      }
    }
  }
}
