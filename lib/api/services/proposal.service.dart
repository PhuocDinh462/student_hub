import 'package:get/get.dart';
import 'package:student_hub/api/base.api.dart';
import 'package:student_hub/models/proposal.dart';

class ProposalService extends BaseApi {
  ProposalService();

  Future<List<Proposal>> getProposal(projectId, [params]) async {
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
}
