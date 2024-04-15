import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class ProfileCompanyViewModel extends ChangeNotifier {
  final ProfileService profileService;
  final AuthService authService;

  ProfileCompanyViewModel(
      {required this.profileService, required this.authService});

  bool _loading = false;
  String _errorMessage = '';
  ProfileCompanyModel _company = const ProfileCompanyModel();

  ProfileCompanyModel get company => _company;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  set company(ProfileCompanyModel value) {
    _company = value;
    notifyListeners();
  }

  void notiListener() {
    notifyListeners();
  }

  Future<void> createProfileCompany(ProfileCompanyModel body) async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data =
          await profileService.createProfileCompany(body);
      String companyJson = jsonEncode(data);
      _company = ProfileCompanyModel.fromJson(companyJson);

      _errorMessage = 'empty';
    } catch (e) {
      _errorMessage = 'Information invalid or already exist. Please try again.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfileCompany(ProfileCompanyModel body) async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data =
          await profileService.updateProfileCompany(body);
      String companyJson = jsonEncode(data);
      _company = ProfileCompanyModel.fromJson(companyJson);

      _errorMessage = 'empty-3';
    } catch (e) {
      _errorMessage = 'Information invalid or already exist. Please try again.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProfileCompany() async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data = await authService.getMe();
      String companyJson = jsonEncode(data['company']);

      _company = ProfileCompanyModel.fromJson(companyJson);

      _errorMessage = 'empty-1';
    } catch (e) {
      _errorMessage = 'Failed to fetch company profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
