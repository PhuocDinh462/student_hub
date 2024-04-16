import 'package:get/get.dart';
import 'package:student_hub/api/base.api.dart';
import 'package:student_hub/models/project.dart';

class ProjectService extends BaseApi {
  ProjectService();

  Future<Project> postProject(body) async {
    try {
      var res = await dio.post('/project', data: body);
      return Project.fromMap(res.data['result']);
    } catch (e) {
      printError(info: 'Post project error: $e');
      throw Exception(e);
    }
  }

  Future<List<Project>> getProject(companyId) async {
    try {
      var res = await dio.get('/project/company/$companyId');
      return (res.data['result'] as List)
          .map<Project>((item) => Project.fromMap(item))
          .toList();
    } catch (e) {
      printError(info: 'Get project error: $e');
      throw Exception(e);
    }
  }

  Future<dynamic> removeProject(projectId) async {
    try {
      var res = await dio.delete(
        '/project/$projectId',
      );
      return res.data;
    } catch (e) {
      printError(info: 'Remove project error: $e');
      throw Exception(e);
    }
  }

  Future<Project> editProject(id, body) async {
    try {
      var res = await dio.patch(
        '/project/$id',
        data: body,
      );
      return Project.fromMap(res.data['result']);
    } catch (e) {
      printError(info: 'Edit project error: $e');
      throw Exception(e);
    }
  }
}
