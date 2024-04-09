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

  Future<dynamic> updateFavoriteProject(
      int studentId, int projectId, int disableFlag) async {
    print(studentId);
    print(projectId);
    print(disableFlag);
    try {
      Response response = await dio.patch(
        '/favoriteProject/$studentId',
        data: {
          'projectId': projectId,
          'disableFlag': disableFlag,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update favorite project');
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