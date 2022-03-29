import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_pro/api_service/api_service.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(TeamsInitial());
  APIService apiService = APIService();

  void emitDialogLoadingSpinner() {
    emit(TeamsLoadingState());
  }

  Future<void> createInvitationEvent() async {
    // await Future.delayed(Duration(seconds: 3));
    final invitationModel = await apiService.createInvitation();
    emit(InvitationCreationState(
        invitationNumber: invitationModel?.invitaionNumber));
  }

  Future getFollowingInfo() async {
    emit(TeamsLoadingState());
    //request followers and followings
  }
}
