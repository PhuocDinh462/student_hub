import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';

class AuthService extends BaseApi {
  AuthService();

  Future<dynamic> getMe() async {
    try {
      Response response = await dio.get('/api/auth/me');

      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
