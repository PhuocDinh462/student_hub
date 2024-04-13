import 'package:get/get.dart';
import 'package:student_hub/api/base.api.dart';
import 'package:student_hub/models/project.dart';

class ProjectService extends BaseApi {
  ProjectService();

  Future<dynamic> postProject(body) async {
    await dio
        .post(
      '/project',
      data: body,
    )
        .then((value) {
      return value.data;
    }).catchError((e) {
      printError(info: 'Post project error: $e');
      throw Exception(e);
    });
  }

  Future<List<Project>> getProject(companyId) async {
    try {
      var response = await dio.get('/project/company/$companyId');
      return (response.data['result'] as List)
          .map<Project>((item) => Project.fromMap(item))
          .toList();
    } catch (e) {
      printError(info: 'Get project error: $e');
      throw Exception(e);
    }
  }

  Future<dynamic> removeProject(projectId) async {
    await dio
        .delete(
      '/project/$projectId',
    )
        .then((value) {
      return value.data;
    }).catchError((e) {
      printError(info: 'Remove project error: $e');
      throw Exception(e);
    });
  }

  Future<dynamic> editProject(id, body) async {
    await dio
        .patch(
      '/project/$id',
      data: body,
    )
        .then((value) {
      return value.data;
    }).catchError((e) {
      printError(info: 'Edit project error: $e');
      throw Exception(e);
    });
  }
}
