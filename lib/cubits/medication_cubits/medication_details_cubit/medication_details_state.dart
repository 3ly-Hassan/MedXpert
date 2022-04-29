part of 'medication_details_cubit.dart';

@immutable
abstract class MedicationDetailsState {}

class MedicationDetailsInitial extends MedicationDetailsState {}

class MedicationDetailsLoadingState extends MedicationDetailsState {}

class ShowSearchListState extends MedicationDetailsState {
  final List searchList;
  ShowSearchListState(this.searchList);
}
