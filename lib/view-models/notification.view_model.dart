import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotifiactionService notificationService;

  NotificationViewModel({required this.notificationService});

  bool _loading = false;
  String _errorMessage = '';
  List<NotificationModel> _notif = [];

  List<NotificationModel> get notif => _notif;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNotification(int? userId) async {
    if (userId == null) {
      _errorMessage = 'User information is not available. Please try again.';
      notifyListeners();
      return;
    }
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<dynamic> data =
          await notificationService.getNotificationByUserId(userId);

      List<NotificationModel> res =
          data.map((e) => NotificationModel.fromMap(e)).toList();

      _notif = res.reversed.toList();
    } catch (e) {
      _errorMessage = 'Failed to fetch student profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
