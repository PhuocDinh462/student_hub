import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/providers/providers.dart';

class MessageService extends BaseApi {
  MessageService() : super();

  Future<dynamic> getConversations(int receiverId, int projectId) async {
    try {
      Response response = await dio.get('/message/$projectId/user/$receiverId');
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
