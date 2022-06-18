import 'package:bloc/bloc.dart';
import 'package:final_pro/db_helper.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future getNotificationList(String drugUniqueId) async {
    emit(NotificationLoadingState());
    final List notificationList =
        await DBHelper.getNotificationsByDrugUniqueId(drugUniqueId);
    emit(GetNotificationListState(notificationList));
  }
}
