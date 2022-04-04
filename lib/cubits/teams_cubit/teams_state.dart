part of 'teams_cubit.dart';

abstract class TeamsState {
  const TeamsState();
}

class TeamsInitialState extends TeamsState {}

class TeamsLoadingState extends TeamsState {}

class GetFollowingStateWithToast extends TeamsState {
  final model;
  GetFollowingStateWithToast(this.model);
}

class GetFollowingStateNoToast extends TeamsState {
  final model;
  GetFollowingStateNoToast(this.model);
}

class TeamsErrorState extends TeamsState {
  final String errorMessage;
  TeamsErrorState({required this.errorMessage});
}
