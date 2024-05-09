import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:student_hub/api/base.api.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/models/proposal.dart';
import 'package:dio/dio.dart';

class ProposalService extends BaseApi {
  ProposalService() : super();

  Future<List<Proposal>> getProposalByProjectId(projectId, [params]) async {
    try {
      var response = await dio.get(
        '/proposal/getByProjectId/$projectId',
        queryParameters: params,
      );
      return (response.data['result']['items'] as List)
          .map<Proposal>((item) => Proposal.fromMap(item))
          .toList();
    } catch (e) {
      printError(info: 'Get proposal error: $e');
      throw Exception(e);
    }
  }

  Future<Proposal> getProposalById(id) async {
    try {
      var response = await dio.get('/proposal/$id');
      return Proposal.fromMap(response.data['result']);
    } catch (e) {
      printError(info: 'Get proposal error: $e');
      throw Exception(e);
    }
  }

  Future<dynamic> createProposal(ProposalModel body) async {
    try {
      Response response = await dio.post('/proposal', data: {
        'projectId': body.projectId,
        'studentId': body.studentId,
        'coverLetter': body.coverLetter,
      });

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create proposal');
    }
  }

  Future<dynamic> updateProposal(ProposalModel body) async {
    try {
      await dio.patch('/proposal/${body.id}', data: {
        'coverLetter': body.coverLetter,
      });
    } catch (e) {
      throw Exception('Failed to create proposal');
    }
  }

  Future<dynamic> getProposalByStudentId(int studentId) async {
    try {
      Response response = await dio.get('/proposal/student/$studentId');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create proposal');
    }
  }

  Future<dynamic> getProposalByStudentIdAndStatusFlag(
      int studentId, int statusFlag) async {
    try {
      Response response = await dio.get('/proposal/project/$studentId',
          queryParameters: {'statusFlag': statusFlag});

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create proposal');
    }
  }

  Future<dynamic> getAllProposalByStudentId(int studentId) async {
    try {
      Response response = await dio.get('/proposal/project/$studentId');

      if (response.data.containsKey('result')) {
        return response.data['result'];
      } else {
        throw Exception('The key "result" does not exist in the response');
      }
    } catch (e) {
      throw Exception('Failed to create proposal');
    }
  }

  Future<void> updateProposalStatusFlag(int id, StatusFlag statusFlag) async {
    try {
      await dio.patch('/proposal/$id', data: {
        'statusFlag': statusFlag.index,
      });
    } catch (e) {
      throw Exception('Failed to update status flag of proposal');
    }
  }
}
