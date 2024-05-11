import 'package:dio/dio.dart';
import 'package:student_hub/api/base.api.dart';

class NotifiactionService extends BaseApi {
  NotifiactionService() : super();

  Future<dynamic> getNotificationByUserId(int userId) async {
    try {
      Response response = await dio.get(
        '/notification/getByReceiverId/$userId',
      );

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to fetch notification');
    }
  }

  Future<dynamic> updateNotificationRead(int notifId) async {
    try {
      await dio.patch(
        '/notification/readNoti/$notifId',
      );
    } catch (e) {
      throw Exception('Failed to fetch notification');
    }
  }
}
