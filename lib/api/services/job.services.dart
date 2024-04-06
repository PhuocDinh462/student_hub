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
      throw Exception('Post job error: ${e.response.data}');
    });
  }
}
