part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class GetNotificationListState extends NotificationState {
  final List notificationList;
  GetNotificationListState(this.notificationList);
}
