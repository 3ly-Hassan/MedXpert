part of 'teams_cubit.dart';

abstract class TeamsState {
  const TeamsState();
}

class TeamsInitialState extends TeamsState {}

class TeamsLoadingState extends TeamsState {}

class GetFollowingStateWithToast extends TeamsState {
  final model;
  final combinedSortedList;
  GetFollowingStateWithToast(this.model, {this.combinedSortedList});
}

class GetFollowingStateNoToast extends TeamsState {
  final model;
  final combinedSortedList;
  GetFollowingStateNoToast(this.model, {this.combinedSortedList});
}

class TeamsErrorState extends TeamsState {
  final String errorMessage;
  TeamsErrorState({required this.errorMessage});
}
