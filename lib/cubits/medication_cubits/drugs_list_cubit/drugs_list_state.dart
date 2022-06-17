part of 'drugs_list_cubit.dart';

@immutable
abstract class DrugsListState {}

class DrugsListInitial extends DrugsListState {}

class DrugsListLoadingState extends DrugsListState {}

class DeletionFailedState extends DrugsListState {}

class GetDrugsListState extends DrugsListState {
  final List drugs;
  GetDrugsListState(this.drugs);
}

class AddingDrugSuccessState extends DrugsListState {
  final List drugs;
  AddingDrugSuccessState(this.drugs);
}

class AddingDrugFailedState extends DrugsListState {}

class UpdateDrugFailedState extends DrugsListState {}

class NotificationCreationState extends DrugsListState {
  final int successNumber;
  final int failNumber;
  NotificationCreationState(this.successNumber, this.failNumber);
}

class DateIsPastState extends DrugsListState {}
