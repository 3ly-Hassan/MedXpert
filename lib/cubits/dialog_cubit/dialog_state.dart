part of 'dialog_cubit.dart';

abstract class DialogState extends Equatable {
  const DialogState();
}

class DialogInitialState extends DialogState {
  @override
  List<Object> get props => [];
}

class DialogLoadingState extends DialogState {
  @override
  List<Object> get props => [];
}

class InvitationCreationState extends DialogState {
  final String? invitationNumber;
  InvitationCreationState({required this.invitationNumber});

  @override
  List<Object?> get props => [invitationNumber];
}

class DialogErrorState extends DialogState {
  final String errorMessage;
  DialogErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
