part of 'teams_cubit.dart';

abstract class TeamsState extends Equatable {
  const TeamsState();
}

class TeamsInitial extends TeamsState {
  @override
  List<Object> get props => [];
}

class TeamsLoadingState extends TeamsState {
  @override
  List<Object?> get props => [];
}

class InvitationCreationState extends TeamsState {
  final String? invitationNumber;
  InvitationCreationState({required this.invitationNumber});
  @override
  List<Object?> get props => [invitationNumber];
}

class TeamsErrorState extends TeamsState {
  final String errorMessage;
  TeamsErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
