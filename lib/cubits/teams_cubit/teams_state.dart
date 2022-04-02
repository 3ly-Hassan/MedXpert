part of 'teams_cubit.dart';

abstract class TeamsState {
  const TeamsState();
}

class TeamsInitialState extends TeamsState {}

class TeamsLoadingState extends TeamsState {}

class GetFollowingState extends TeamsState {
  final model;
  GetFollowingState(this.model);
}

class InvitationCreationState extends TeamsState {
  final String? invitationNumber;
  InvitationCreationState({required this.invitationNumber});
}

class TeamsErrorState extends TeamsState {
  final String errorMessage;
  TeamsErrorState({required this.errorMessage});
}
