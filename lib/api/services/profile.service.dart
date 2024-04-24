import 'dart:io';

import 'package:dio/dio.dart';
import 'package:student_hub/api/base.api.dart';
import 'package:student_hub/models/models.dart';

class ProfileService extends BaseApi {
  ProfileService() : super();

  Future<dynamic> createProfileCompany(ProfileCompanyModel body) async {
    try {
      Response response = await dio.post('/profile/company', data: {
        'companyName': body.companyName,
        'size': body.size,
        'website': body.website,
        'description': body.description
      });

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create profile company');
    }
  }

  Future<dynamic> updateProfileCompany(ProfileCompanyModel body) async {
    try {
      Response response = await dio.put('/profile/company/${body.id}', data: {
        'companyName': body.companyName,
        'website': body.website,
        'description': body.description
      });

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update profile company');
    }
  }

  Future<dynamic> getProfileCompany(String id) async {
    try {
      Response response = await dio.get('/profile/company/$id');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get profile company');
    }
  }

  Future<dynamic> createProfileStudent(
      TechnicalModel techStack, List<TechnicalModel> skillSet) async {
    try {
      Response response = await dio.post('/profile/student', data: {
        'techStackId': techStack.id,
        'skillSets': skillSet.map((e) => e.id).toList()
      });

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create profile student');
    }
  }

  Future<dynamic> updateProfileStudent(int studentId, TechnicalModel techStack,
      List<TechnicalModel> skillSet) async {
    try {
      Response response = await dio.put('/profile/student/$studentId', data: {
        'techStackId': techStack.id,
        'skillSets': skillSet.map((e) => e.id).toList()
      });

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update profile student');
    }
  }

  Future<dynamic> getProfileStudent(int studentId) async {
    try {
      Response response = await dio.get(
        '/profile/student/$studentId',
      );

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get profile student');
    }
  }

  Future<dynamic> getTechStackStudent(String studentId) async {
    try {
      Response response = await dio.get(
        '/profile/student/$studentId/techStack',
      );

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get TechStack');
    }
  }

  Future<dynamic> getAllTechStack() async {
    try {
      Response response = await dio.get(
        '/techstack/getAllTechStack',
      );
      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get all techstack');
    }
  }

  Future<dynamic> getTechStackById(String techStackId) async {
    try {
      Response response = await dio.get(
        '/techstack/$techStackId',
      );

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get TechStack by id "$techStackId"');
    }
  }

  Future<dynamic> createTechStack(String name) async {
    try {
      Response response = await dio.post(
        '/techstack/createTechStack',
        data: {'name': name},
      );

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create TechStack student');
    }
  }

  Future<dynamic> getAllSkillSet() async {
    try {
      Response response = await dio.get('/skillset/getAllSkillSet');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get all skillset');
    }
  }

  Future<dynamic> createSkillSet(String name) async {
    try {
      Response response =
          await dio.post('/skillset/createSkillSet', data: {name: name});

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create skillset student');
    }
  }

  Future<dynamic> getSkillSetById(String id) async {
    try {
      Response response = await dio.get('/skillset/$id');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get skillset by id "$id"');
    }
  }

  Future<dynamic> getLanguageStudent(String studentId) async {
    try {
      Response response = await dio.get('/language/getByStudentId/$studentId');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get language');
    }
  }

  Future<dynamic> updateLanguageStudent(
      int studentId, List<LanguageModel> languages) async {
    try {
      List<Map<String, dynamic>> lag = languages.map((e) {
        var map = e.toMap();
        map.remove('createdAt');
        map.remove('updatedAt');
        map.remove('deleteAt');
        e.id != -1 ? '' : map.remove('studentId');
        e.id != -1 ? '' : map.remove('id');
        return map;
      }).toList();

      Response response = await dio.put(
          '/language/updateByStudentId/$studentId',
          data: {'languages': lag});

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update language');
    }
  }

  Future<dynamic> getEducationStudent(String studentId) async {
    try {
      Response response = await dio.get('/education/getByStudentId/$studentId');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get education');
    }
  }

  Future<dynamic> updateEducationStudent(
      int studentId, List<EducationModel> education) async {
    try {
      List<Map<String, dynamic>> edu = education.map((e) {
        var map = e.toMap();
        map.remove('createdAt');
        map.remove('updatedAt');
        map.remove('deleteAt');
        e.id != -1 ? '' : map.remove('studentId');
        e.id != -1 ? '' : map.remove('id');
        return map;
      }).toList();

      Response response = await dio.put(
          '/education/updateByStudentId/$studentId',
          data: {'education': edu});

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update education');
    }
  }

  Future<dynamic> getExperienceStudent(String studentId) async {
    try {
      Response response =
          await dio.get('/experience/getByStudentId/$studentId');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get experience');
    }
  }

  Future<dynamic> updateExperienceStudent(
      int studentId, List<ExperienceModel> experience) async {
    try {
      List<Map<String, dynamic>> exp = experience.map((e) {
        var map = e.toMap();
        map.remove('createdAt');
        map.remove('updatedAt');
        map.remove('deleteAt');
        e.id != -1 ? '' : map.remove('studentId');
        e.id != -1 ? '' : map.remove('id');
        map['skillSets'] = e.skillSets.map((e) => e.id.toString()).toList();
        return map;
      }).toList();

      Response response = await dio.put(
          '/experience/updateByStudentId/$studentId',
          data: {'experience': exp});
      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update experience student');
    }
  }

  Future<dynamic> getResumeStudent(int studentId) async {
    try {
      Response response = await dio.get('/profile/student/$studentId/resume');
      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get resume');
    }
  }

  Future<dynamic> updateResumeStudent(int studentId, File file) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });

      Response response =
          await dio.put('/profile/student/$studentId/resume', data: formData);
      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update resume');
    }
  }

  Future<dynamic> getTranscriptStudent(int studentId) async {
    try {
      Response response =
          await dio.get('/profile/student/$studentId/transcript');
      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to get transcript');
    }
  }

  Future<dynamic> updateTranscriptStudent(int studentId, File file) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });

      Response response = await dio
          .put('/profile/student/$studentId/transcript', data: formData);
      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to update transcript');
    }
  }
}
