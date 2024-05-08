import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotifiactionService notificationService;

  NotificationViewModel({required this.notificationService});

  bool _loading = false;
  String _errorMessage = '';
  int _numberOfNotifications = 0;
  List<NotificationModel> _notif = [];

  List<NotificationModel> get notif => _notif;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;
  int get numberOfNotifications => _numberOfNotifications;

  Future<void> fetchNotification(
      {int? userId, bool isReload = true, required Role currentRole}) async {
    if (userId == null) {
      _errorMessage = 'User information is not available. Please try again.';
      if (isReload) {
        notifyListeners();
      }
      return;
    }
    _loading = true;
    _errorMessage = '';
    if (isReload) {
      notifyListeners();
    }
    try {
      List<dynamic> data =
          await notificationService.getNotificationByUserId(userId);

      int cnt = 0;
      List<NotificationModel> res = [];
      for (var e in data) {
        NotificationModel item = NotificationModel.fromMap(e);

        bool isStudent = currentRole == Role.student &&
            item.typeNotifyFlag == TypeNotifyFlag.offer;
        bool isCompany = currentRole == Role.company &&
            item.typeNotifyFlag == TypeNotifyFlag.submitted;

        if (item.typeNotifyFlag == TypeNotifyFlag.chat ||
            item.typeNotifyFlag == TypeNotifyFlag.interview ||
            item.typeNotifyFlag == TypeNotifyFlag.hired) {
          if (item.notifyFlag == NotifyFlag.unread) {
            cnt++;
          }
          res.add(item);
        }

        if ((isStudent || isCompany)) {
          if (item.notifyFlag == NotifyFlag.unread) {
            cnt++;
          }
          res.add(item);
        }
      }

      _numberOfNotifications = cnt;
      _notif = res.reversed.toList();
      _notif.sort((a, b) => b.id.compareTo(a.id));
    } catch (e) {
      _errorMessage = 'Failed to fetch notification';
    } finally {
      _loading = false;
      if (isReload) {
        notifyListeners();
      }
    }
  }
}
