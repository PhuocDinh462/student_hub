import 'package:get/get.dart';
import 'package:student_hub/api/base.api.dart';

class JobService extends BaseApi {
  JobService();

  Future<dynamic> postJob(body) async {
    await dio
        .post(
      '/project',
      data: body,
    )
        .then((value) {
      return value.data;
    }).catchError((e) {
      printError(info: 'Post job error: $e');
      throw Exception(e);
    });
  }

  Future<dynamic> getJob(companyId) async {
    await dio
        .get(
      '/project/company/$companyId',
    )
        .then((value) {
      return value.data;
    }).catchError((e) {
      printError(info: 'Get job error: $e');
      throw Exception(e);
    });
  }

  Future<dynamic> removeJob(projectId) async {
    await dio
        .delete(
      '/project/$projectId',
    )
        .then((value) {
      return value.data;
    }).catchError((e) {
      printError(info: 'Remove job error: $e');
      throw Exception(e);
    });
  }
}
