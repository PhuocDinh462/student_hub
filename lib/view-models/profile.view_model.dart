import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class ProfileCompanyViewModel extends ChangeNotifier {
  final ProfileService profileService;

  ProfileCompanyViewModel({
    required this.profileService,
  });

  bool _loading = false;
  String _errorMessage = '';
  ProfileCompany _company = ProfileCompany();

  ProfileCompany get company => _company;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  void notiListener() {
    notifyListeners();
  }

  Future<void> createProfileCompany(ProfileCompany body) async {
    _loading = true; // Set loading flag to true before making the API call.
    _errorMessage = ''; // Clear any previous error message.
    notifyListeners();

    try {
      // Call the getUsers() method from the UserRepository to fetch user data from the API.
      _company = await profileService.createProfileCompany(body);
      _errorMessage = 'empty';
    } catch (e) {
      // If an exception occurs during the API call, set the error message to display the error.
      _errorMessage = 'Information invalid or already exist. Please try again.';
    } finally {
      // After API call is completed, set loading flag to false and notify listeners of data change.
      _loading = false;
      notifyListeners();
    }
  }
}
