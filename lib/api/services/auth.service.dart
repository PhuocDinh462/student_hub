import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x;
import 'package:student_hub/api/api.dart';
import 'package:student_hub/providers/providers.dart';

class AuthService extends BaseApi {
  AuthService() : super();

  Future<dynamic> getMe() async {
    try {
      Response response = await dio.get('/auth/me');
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> signUp(
      String email, String password, String fullname, int role) async {
    try {
      Response response = await dio.post(
        '/auth/sign-up',
        data: {
          'email': email,
          'password': password,
          'fullname': fullname,
          'role': role,
        },
      );
      return response;
    } catch (e) {
      // print(e);
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      Response response = await dio.post(
        '/auth/sign-in',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      // print(e);
      throw Exception('Failed to fetch users');
    }
  }

  Future<dynamic> logout(String token, UserProvider userProvider) async {
    try {
      Response response = await dio.post('/auth/logout');
      if (response.statusCode == 201) {
        ProjectProvider projectProvider = get_x.Get.find();
        userProvider.removeCurrentUser();
        projectProvider.delete();
      }
      return response;
    } catch (e) {
      print(e);
    }
  }
}
