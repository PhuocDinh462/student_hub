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
      print(e);
      throw Exception('Failed to fetch users');
    }
  }
}
