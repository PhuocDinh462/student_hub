import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class ProposalStudentViewModel extends ChangeNotifier {
  final ProposalService proposalService;

  ProposalStudentViewModel({
    required this.proposalService,
  });

  bool _loading = false;
  String _errorMessage = '';
  String _successMessage = '';

  bool get loading => _loading;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  List<ProposalModel> _proposals = [];
  List<ProposalModel> _proposalActive = [];
  List<ProposalModel> _proposalSubmited = [];

  List<ProposalModel> get proposals => _proposals;
  List<ProposalModel> get proposalActive => _proposalActive;
  List<ProposalModel> get proposalSubmited => _proposalSubmited;

  set errorMessage(String message) {
    _errorMessage = message;
  }

  set successMessage(String message) {
    _successMessage = message;
  }

  void setProposals(List<ProposalModel> proposals) {
    _proposals = proposals;
    notifyListeners();
  }

  Future<void> createProposalStudent(ProposalModel body) async {
    _loading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      await proposalService.createProposal(body);
      _successMessage = 'Your requirement has been sent successfully.';
    } catch (e) {
      _errorMessage = 'An error occurred, please try again...';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateProposalStudent(ProposalModel body) async {
    _loading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      await proposalService.updateProposal(body);
      _successMessage = 'Your requirement has been updated successfully.';
    } catch (e) {
      _errorMessage = 'An error occurred, please try again...';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProposal(int? studentId, int statusFlag) async {
    if (studentId == null) {
      _errorMessage = 'Student information is not available. Please try again.';
      notifyListeners();
    }

    _loading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      List<dynamic> data = await proposalService
          .getProposalByStudentIdAndStatusFlag(studentId!, statusFlag);

      List<ProposalModel> res =
          data.map((e) => ProposalModel.fromMap(e)).toList();
      if (StatusFlag.values[statusFlag] == StatusFlag.waiting) {
        _proposalSubmited = res.reversed.toList();
      } else {
        _proposalActive = res.reversed.toList();
      }
    } catch (e) {
      _errorMessage = '';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProposalByStudentId(int? studentId) async {
    if (studentId == null) {
      _errorMessage = 'Student information is not available. Please try again.';
      notifyListeners();
    }

    _loading = true;
    _errorMessage = '';
    _successMessage = '';
    notifyListeners();

    try {
      List<dynamic> data =
          await proposalService.getProposalByStudentId(studentId!);

      List<ProposalModel> res =
          data.map((e) => ProposalModel.fromMap(e)).toList();
      _proposals = res;
    } catch (e) {
      _errorMessage = '';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
