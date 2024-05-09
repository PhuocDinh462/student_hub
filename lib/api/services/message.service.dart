import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';

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

  Future<dynamic> getAllMessage() async {
    try {
      Response response = await dio.get('/message');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create profile company');
    }
  }

  Future<dynamic> getMessageByProjectId(id) async {
    try {
      Response response = await dio.get('/message/$id');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create profile company');
    }
  }
}
