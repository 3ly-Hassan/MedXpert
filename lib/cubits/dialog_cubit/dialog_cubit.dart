import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api_service/api_service.dart';

part 'dialog_state.dart';

class DialogCubit extends Cubit<DialogState> {
  DialogCubit() : super(DialogInitialState());

  APIService apiService = APIService();

  void emitDialogLoadingState() {
    emit(DialogLoadingState());
  }

  void emitDialogInitialState() {
    emit(DialogInitialState());
  }

  void emitDialogErrorState(String errorMessage) {
    emit(DialogErrorState(errorMessage: errorMessage));
  }

  Future<void> createInvitationEvent() async {
    // await Future.delayed(Duration(seconds: 3));
    final invitationModel = await apiService.createInvitation();
    emit(
      InvitationCreationState(
          invitationNumber: invitationModel?.invitaionNumber),
    );
  }
}
