import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotifiactionService notificationService;

  NotificationViewModel({required this.notificationService});

  final Map<String, int> _numberOfChat = {};
  final List<NotificationModel> _notifOrigin = [];
  bool _loading = false;
  String _errorMessage = '';
  int _numberOfNotifications = 0;
  List<NotificationModel> _notif = [];

  List<NotificationModel> get notif => _notif;
  List<NotificationModel> get notifOrigin => _notifOrigin;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;
  int get numberOfNotifications => _numberOfNotifications;
  Map<String, int> get numberOfChat => _numberOfChat;

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
      _numberOfChat.clear();
      _notifOrigin.clear();

      List<NotificationModel> res = [];
      for (var e in data) {
        NotificationModel item = NotificationModel.fromMap(e);
        _notifOrigin.add(item);

        bool isStudent = currentRole == Role.student &&
            item.typeNotifyFlag == TypeNotifyFlag.offer;
        bool isCompany = currentRole == Role.company &&
            item.typeNotifyFlag == TypeNotifyFlag.submitted;

        if (item.typeNotifyFlag == TypeNotifyFlag.chat) {
          int index = res.indexWhere((n) =>
              n.senderId == item.senderId &&
              n.typeNotifyFlag == TypeNotifyFlag.chat);

          if (item.notifyFlag == NotifyFlag.unread) {
            if (_numberOfChat.containsKey('${item.senderId}')) {
              _numberOfChat['${item.senderId}'] =
                  (_numberOfChat['${item.senderId}'] ?? 0) + 1;
            } else {
              _numberOfChat['${item.senderId}'] = 1;
            }
          }

          if (index != -1) {
            DateTime currentItemSentAt =
                DateTime.parse(item.message!.createdAt ?? '');
            DateTime existingItemSentAt =
                DateTime.parse(res[index].message!.createdAt ?? '');

            if (currentItemSentAt.isAfter(existingItemSentAt)) {
              res[index] = item;
            }
          } else {
            res.add(item);
          }
        }

        if (item.typeNotifyFlag == TypeNotifyFlag.interview ||
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

      _numberOfNotifications = cnt + _numberOfChat.length;
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

  Future<void> updateMessageNotificationRead(int senderId) async {
    try {
      for (var e in _notifOrigin) {
        if (e.senderId == senderId &&
            e.typeNotifyFlag == TypeNotifyFlag.chat &&
            e.notifyFlag == NotifyFlag.unread) {
          notificationService.updateNotificationRead(e.id);
        }
      }
    } catch (e) {
      _errorMessage = 'Failed to update notification';
    } finally {
      _loading = false;
    }
  }

  void addNotification(NotificationModel item, Role currentRole) {
    int cnt = 0;
    bool isStudent = currentRole == Role.student &&
        item.typeNotifyFlag == TypeNotifyFlag.offer;
    bool isCompany = currentRole == Role.company &&
        item.typeNotifyFlag == TypeNotifyFlag.submitted;

    int index1 = _notif.indexWhere((element) => element.id == item.id);
    int index2 = _notifOrigin.indexWhere((element) => element.id == item.id);

    if (index2 != -1) {
      _notifOrigin.add(item);
    }
    _numberOfNotifications = _numberOfNotifications - numberOfChat.length;

    if (item.typeNotifyFlag == TypeNotifyFlag.chat) {
      int index = _notif.indexWhere((n) =>
          n.senderId == item.senderId &&
          n.typeNotifyFlag == TypeNotifyFlag.chat);

      if (item.notifyFlag == NotifyFlag.unread) {
        if (_numberOfChat.containsKey('${item.senderId}')) {
          _numberOfChat['${item.senderId}'] =
              (_numberOfChat['${item.senderId}'] ?? 0) + 1;
        } else {
          _numberOfChat['${item.senderId}'] = 1;
        }
      }

      if (index != -1) {
        DateTime currentItemSentAt =
            DateTime.parse(item.message!.createdAt ?? '');
        DateTime existingItemSentAt =
            DateTime.parse(_notif[index].message!.createdAt ?? '');

        if (currentItemSentAt.isAfter(existingItemSentAt)) {
          _notif[index] = item;
        }
      } else {
        if (index1 != -1) {
          _notif.add(item);
        }
      }
    }

    if (item.typeNotifyFlag == TypeNotifyFlag.interview ||
        item.typeNotifyFlag == TypeNotifyFlag.hired) {
      if (item.notifyFlag == NotifyFlag.unread) {
        cnt++;
      }
      if (index1 != -1) {
        _notif.add(item);
      }
    }

    if ((isStudent || isCompany)) {
      if (item.notifyFlag == NotifyFlag.unread) {
        cnt++;
      }
      if (index1 != -1) {
        _notif.add(item);
      }
    }

    _numberOfNotifications =
        _numberOfNotifications + cnt + _numberOfChat.length;
    _notif.sort((a, b) => b.id.compareTo(a.id));

    notifyListeners();
  }
}
