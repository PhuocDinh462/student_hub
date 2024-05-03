import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class ProposalStudentViewModel extends ChangeNotifier {
  final ProposalService proposalService;

  ProposalStudentViewModel({
    required this.proposalService,
  });

  bool _loading = false;
  String errorMessage = '';
  String successMessage = '';

  bool get loading => _loading;

  List<ProposalModel> _proposals = [];
  List<ProposalModel> _proposalActive = [];
  List<ProposalModel> _proposalSubmited = [];

  List<ProposalModel> get proposals => _proposals;
  List<ProposalModel> get proposalActive => _proposalActive;
  List<ProposalModel> get proposalSubmited => _proposalSubmited;

  void setProposals(List<ProposalModel> proposals) {
    _proposals = proposals;
    notifyListeners();
  }

  Future<void> createProposalStudent(ProposalModel body) async {
    _loading = true;
    notifyListeners();
    errorMessage = '';
    successMessage = '';

    try {
      await proposalService.createProposal(body);
      successMessage = 'Your requirement has been sent successfully.';
    } catch (e) {
      errorMessage = 'An error occurred, please try again...';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateProposalStudent(ProposalModel body) async {
    _loading = true;
    notifyListeners();
    errorMessage = '';
    successMessage = '';

    try {
      await proposalService.updateProposal(body);
      successMessage = 'Your requirement has been updated successfully.';
    } catch (e) {
      errorMessage = 'An error occurred, please try again...';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProposal(int? studentId, int statusFlag) async {
    if (studentId == null) {
      errorMessage = 'Student information is not available. Please try again.';
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();
    errorMessage = '';
    successMessage = '';

    try {
      List<dynamic> data = await proposalService
          .getProposalByStudentIdAndStatusFlag(studentId, statusFlag);

      List<ProposalModel> res =
          data.map((e) => ProposalModel.fromMap(e)).toList();
      if (StatusFlag.values[statusFlag] == StatusFlag.waiting) {
        _proposalSubmited = res.reversed.toList();
      } else {
        _proposalActive = res.reversed.toList();
      }
    } catch (e) {
      errorMessage = '';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProposalByStudentId(int? studentId) async {
    if (studentId == null) {
      errorMessage = 'Student information is not available. Please try again.';
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();
    errorMessage = '';
    successMessage = '';

    try {
      List<dynamic> data =
          await proposalService.getProposalByStudentId(studentId);

      List<ProposalModel> res =
          data.map((e) => ProposalModel.fromMap(e)).toList();
      _proposals = res;
    } catch (e) {
      errorMessage = '';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProjectWorkingOrArchived(int? studentId, int status) async {
    if (studentId == null) {
      errorMessage = 'Student information is not available. Please try again.';
      notifyListeners();
      return;
    }

    _loading = true;
    notifyListeners();
    errorMessage = '';
    successMessage = '';

    try {
      List<dynamic> data =
          await proposalService.getAllProposalByStudentId(studentId);

      List<ProposalModel> res =
          data.map((e) => ProposalModel.fromMap(e)).toList();

      if (status == 1) {
        _proposals = res.reversed
            .where((e) =>
                e.project?.typeFlag == TypeFlag.working &&
                e.statusFlag == StatusFlag.hired)
            .toList();
      } else {
        _proposals = res.reversed
            .where((e) =>
                e.project?.typeFlag == TypeFlag.archived &&
                e.statusFlag == StatusFlag.hired)
            .toList();
      }
    } catch (e) {
      errorMessage = '';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
