import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';

class UserService extends BaseApi {
  UserService() : super();

  Future<dynamic> forgotPassword(String email) async {
    try {
      Response response = await dio.post(
        '/user/forgotPassword',
        data: {
          'email': email,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> changePassword<String>(
      String oldPassword, String newPassword) async {
    try {
      Response response = await dio.put(
        '/user/changePassword',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
