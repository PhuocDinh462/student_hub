import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/utils/utils.dart';

class ChatService extends BaseApi {
  ChatService() : super();

  Future<dynamic> getConversations(int receiverId, int projectId) async {
    try {
      Response response = await dio.get('/message/$projectId/user/$receiverId');
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> sendMessage(
      int projectId, int senderId, int receiverId, content) async {
    try {
      Response response = await dio.post(
        '/message/sendMessage',
        data: {
          'projectId': projectId,
          'receiverId': receiverId,
          'senderId': senderId,
          'content': content,
          'messageFlag': 0
        },
      );
      return response;
    } catch (e) {
      // print(e);
      throw Exception('Failed to send message');
    }
  }

  Future<dynamic> createInterview(
      String title,
      String content,
      DateTime startTime,
      DateTime endTime,
      int projectId,
      int senderId,
      int receiverId) async {
    try {
      Response response = await dio.post(
        '/interview',
        data: {
          'title': title,
          'content': content,
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
          'projectId': projectId,
          'receiverId': receiverId,
          'senderId': senderId,
          'meeting_room_code': MeetingRoom.generateMeetingRoomCode(),
          'meeting_room_id': MeetingRoom.generateMeetingRoomId(),
        },
      );
      return response;
    } catch (e) {
      // print(e);
      throw Exception('Failed to send message');
    }
  }

  Future<dynamic> updateInterview(
    String title,
    DateTime startTime,
    DateTime endTime,
    int interviewId,
  ) async {
    try {
      Response response = await dio.patch(
        '/interview/$interviewId',
        data: {
          'title': title,
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
        },
      );
      return response;
    } catch (e) {
      // print(e);
      throw Exception('Failed to send message');
    }
  }

  Future<dynamic> disableInterview(
    int interviewId,
  ) async {
    try {
      Response response = await dio.patch('/interview/$interviewId/disable');
      return response;
    } catch (e) {
      // print(e);
      throw Exception('Failed to send message');
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
}
