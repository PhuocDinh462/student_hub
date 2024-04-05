import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';

class AuthService extends BaseApi {
  AuthService() : super();

  Future<dynamic> getMe() async {
    try {
      Response response = await dio.get('/auth/me');
      print(response);
      return response.data['result'];
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch users');
    }
  }
}
