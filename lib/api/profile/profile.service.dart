import 'package:dio/dio.dart';
import 'package:student_hub/api/base.api.dart';
import 'package:student_hub/models/models.dart';

class ProfileService extends BaseApi {
  ProfileService();

  Future<ProfileCompany> createProfileCompany(ProfileCompany body) async {
    try {
      Response response = await dio.post('/api/profile/company', data: {
        'companyName': '${body.companyName}',
        'size': body.size,
        'website': '${body.website}',
        'description': '${body.description}'
      });

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
