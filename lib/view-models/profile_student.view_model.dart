import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/models/models.dart';

class ProfileStudentViewModel extends ChangeNotifier {
  final ProfileService profileService;

  ProfileStudentViewModel({
    required this.profileService,
  });

  bool _loading = false;
  bool _isChange = false;
  String _errorMessage = '';
  ProfileStudentModel _student = const ProfileStudentModel();
  List<TechnicalModel> _listTechStack = [];
  List<TechnicalModel> _listSkillset = [];

  ProfileStudentModel get student => _student;
  List<TechnicalModel> get listTechStack => _listTechStack;
  List<TechnicalModel> get listSkillset => _listSkillset;

  bool get loading => _loading;
  bool get isChange => _isChange;
  String get errorMessage => _errorMessage;

  void setIsChange(bool value) {
    _isChange = value;
    notifyListeners();
  }

  void setTechStack(TechnicalModel value) {
    _student = _student.copyWith(techStack: value);
    notifyListeners();
  }

  void setSkillSet(List<TechnicalModel> value) {
    _student = _student.copyWith(skillSets: value);
    notifyListeners();
  }

  void updateSkillSet(List<TechnicalModel> value) {
    _student = _student.copyWith(skillSets: value);
    notifyListeners();
  }

  void addSkillset(TechnicalModel value) {
    _student = _student.copyWith(skillSets: [..._student.skillSets, value]);
    notifyListeners();
  }

  void removeSkillset(TechnicalModel value) {
    _student = _student.copyWith(skillSets: [
      ..._student.skillSets.where((element) => element.id != value.id)
    ]);
    notifyListeners();
  }

  void setLanguage(List<LanguageModel> value) {
    _student = _student.copyWith(languages: value);
    notifyListeners();
  }

  void addLanguage(LanguageModel value) {
    _student = _student.copyWith(languages: [value, ..._student.languages]);
    notifyListeners();
  }

  void removeLanguage(LanguageModel value) {
    _student = _student.copyWith(languages: [
      ..._student.languages.where((element) => element.id != value.id)
    ]);
    notifyListeners();
  }

  void setEducation(List<EducationModel> value) {
    _student = _student.copyWith(educations: value);
    notifyListeners();
  }

  void addEducation(EducationModel value) {
    _student = _student.copyWith(educations: [..._student.educations, value]);
    notifyListeners();
  }

  void removeEducation(EducationModel value) {
    _student = _student.copyWith(educations: [
      ..._student.educations.where((element) => element.id != value.id)
    ]);
    notifyListeners();
  }

  void setExperience(List<ExperienceModel> value) {
    _student = _student.copyWith(experiences: value);
    notifyListeners();
  }

  void addExperience(ExperienceModel value) {
    _student = _student.copyWith(experiences: [..._student.experiences, value]);
    notifyListeners();
  }

  void removeExperience(ExperienceModel value) {
    _student = _student.copyWith(experiences: [
      ..._student.experiences.where((element) => element.id != value.id)
    ]);
    notifyListeners();
  }

  void notiListener() {
    notifyListeners();
  }

  Future<void> fetchProfileStudent(int? studentId) async {
    if (studentId == null) {
      _student = const ProfileStudentModel();
      _isChange = false;
      notifyListeners();
      return;
    }
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data =
          await profileService.getProfileStudent(studentId);
      String studentJson = jsonEncode(data);

      _student = ProfileStudentModel.fromJson(studentJson);
    } catch (e) {
      _errorMessage = 'Failed to fetch student profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTechnicalData() async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<dynamic> techStackData = await profileService.getAllTechStack();
      List<dynamic> skillSetData = await profileService.getAllSkillSet();
      _listTechStack =
          techStackData.map((item) => TechnicalModel.fromMap(item)).toList();

      _listSkillset =
          skillSetData.map((item) => TechnicalModel.fromMap(item)).toList();

      TechnicalModel defaultTechModel =
          const TechnicalModel(name: 'Select Tech Stack');

      _listTechStack.insert(0, defaultTechModel);
    } catch (e) {
      _errorMessage = 'Failed to fetch student profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> createProfileStudent() async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data = await profileService.createProfileStudent(
          student.techStack, student.skillSets);
      String studentJson = jsonEncode(data);

      ProfileStudentModel res = ProfileStudentModel.fromJson(studentJson);

      setSkillSet(res.skillSets);
      setTechStack(res.techStack);
    } catch (e) {
      _errorMessage = 'Failed to fetch company profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfileStudent(int? userId) async {
    _isChange = false;
    if (userId == null) {
      createProfileStudent();
      return;
    }
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data = await profileService.updateProfileStudent(
          userId, student.techStack, student.skillSets);
      String studentJson = jsonEncode(data);

      ProfileStudentModel res = ProfileStudentModel.fromJson(studentJson);

      setSkillSet(res.skillSets);
      setTechStack(res.techStack);
    } catch (e) {
      _errorMessage = 'Failed to fetch company profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateLanguageStudent(int studentId) async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<dynamic> data = await profileService.updateLanguageStudent(
          studentId, student.languages);
      String languageJson = jsonEncode(data);

      List<LanguageModel> languages = (jsonDecode(languageJson) as List)
          .map((item) => LanguageModel.fromJson(item))
          .toList();
      setLanguage(languages);
      print(languageJson);
    } catch (e) {
      print(e);

      _errorMessage = 'Failed to fetch company profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateEducationStudent(int studentId) async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data = await profileService.updateEducationStudent(
          studentId, student.educations);
      String educationJson = jsonEncode(data);

      List<EducationModel> education = (jsonDecode(educationJson) as List)
          .map((item) => EducationModel.fromJson(item))
          .toList();
      setEducation(education);
    } catch (e) {
      _errorMessage = 'Failed to fetch company profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateExperienceStudent(String studentId) async {
    _loading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      Map<String, dynamic> data = await profileService.updateExperienceStudent(
          studentId, student.experiences);
      String experienceJson = jsonEncode(data);

      List<ExperienceModel> experience = (jsonDecode(experienceJson) as List)
          .map((item) => ExperienceModel.fromJson(item))
          .toList();
      setExperience(experience);
    } catch (e) {
      _errorMessage = 'Failed to fetch company profile';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
