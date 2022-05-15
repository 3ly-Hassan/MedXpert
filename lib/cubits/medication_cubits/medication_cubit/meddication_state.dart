part of 'medication_cubit.dart';

abstract class MedicationState {}

class MedicationInitial extends MedicationState {}

class GetFollowersListState extends MedicationState {
  final List followersList;
  GetFollowersListState(this.followersList);
}

class MedicationLoadingState extends MedicationState {}
