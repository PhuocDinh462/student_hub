import 'package:dio/dio.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

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

  Future<void> updateFavoriteProject(
      int studentId, int projectId, int disableFlag) async {
    try {
      await dio.patch(
        '/favoriteProject/$studentId',
        data: {
          'projectId': projectId,
          'disableFlag': disableFlag,
        },
      );
      // return response;
    } catch (e) {
      throw Exception('Failed to update favorite project');
    }
  }

  Future<List<Project>> getProjects([Map<String, Object?>? params]) async {
    if (params != null) {
      params.removeWhere(
          (key, value) => value == null || value == '' || value == -1);
    }
    try {
      Response response = await dio.get(
        '/project',
        queryParameters: params,
      );
      return response.data['result']
          .map<Project>((item) => Project.fromMap(item))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      throw Exception('Failed to fetch projects');
    }
  }

  Future<dynamic> filterProject(Map<String, dynamic> queries) async {
    try {
      Response response = await dio.get(
        '/project',
        queryParameters: queries,
      );
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch project');
    }
  }

  Future<dynamic> getProjectById(int projectId) async {
    try {
      Response response = await dio.get(
        '/project/$projectId',
      );

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to fetch notification');
    }
  }
}
