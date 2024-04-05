import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';

class ProjectService extends BaseApi {
  ProjectService() : super();
  Future<dynamic> getFavoriteProjects(int studentId) async {
    try {
      Response response = await dio.get(
        '/favoriteProject/$studentId',
      );
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch saved projects');
    }
  }

  Future<dynamic> getProjects() async {
    try {
      Response response = await dio.get(
        '/project',
      );
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch projects');
    }
  }
}
