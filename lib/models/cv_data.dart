// models/cv_data.dart
import 'package:flutter/foundation.dart';
import 'education.dart';
import 'work_experience.dart';
import 'skill.dart';

class CVData with ChangeNotifier {
  String _templateId;
  String _fullName = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _profileSummary = '';
  List<Education> _education = [];
  List<WorkExperience> _workExperience = [];
  List<Skill> _skills = [];
  List<String> _certifications = [];
  List<String> _languages = [];

  // Getters
  String get templateId => _templateId;
  String get fullName => _fullName;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  String get profileSummary => _profileSummary;
  List<Education> get education => List.unmodifiable(_education);
  List<WorkExperience> get workExperience => List.unmodifiable(_workExperience);
  List<Skill> get skills => List.unmodifiable(_skills);
  List<String> get certifications => List.unmodifiable(_certifications);
  List<String> get languages => List.unmodifiable(_languages);

  CVData({required String templateId}) : _templateId = templateId;

  // Setters with notification
  set templateId(String value) {
    _templateId = value;
    notifyListeners();
  }

  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  set profileSummary(String value) {
    _profileSummary = value;
    notifyListeners();
  }

  // List manipulation methods
  void addEducation(Education education) {
    _education.add(education);
    notifyListeners();
  }

  void removeEducation(int index) {
    if (index >= 0 && index < _education.length) {
      _education.removeAt(index);
      notifyListeners();
    }
  }

  void setEducationList(List<Education> educationList) {
    _education = List.from(educationList);
    notifyListeners();
  }

  void addWorkExperience(WorkExperience experience) {
    _workExperience.add(experience);
    notifyListeners();
  }

  void removeWorkExperience(int index) {
    if (index >= 0 && index < _workExperience.length) {
      _workExperience.removeAt(index);
      notifyListeners();
    }
  }

  void setWorkExperienceList(List<WorkExperience> experienceList) {
    _workExperience = List.from(experienceList);
    notifyListeners();
  }

  void addSkill(Skill skill) {
    _skills.add(skill);
    notifyListeners();
  }

  void removeSkill(int index) {
    if (index >= 0 && index < _skills.length) {
      _skills.removeAt(index);
      notifyListeners();
    }
  }

  void setSkillsList(List<Skill> skillsList) {
    _skills = List.from(skillsList);
    notifyListeners();
  }

  void addCertification(String certification) {
    _certifications.add(certification);
    notifyListeners();
  }

  void removeCertification(int index) {
    if (index >= 0 && index < _certifications.length) {
      _certifications.removeAt(index);
      notifyListeners();
    }
  }

  void setCertificationsList(List<String> certificationsList) {
    _certifications = List.from(certificationsList);
    notifyListeners();
  }

  void addLanguage(String language) {
    _languages.add(language);
    notifyListeners();
  }

  void removeLanguage(int index) {
    if (index >= 0 && index < _languages.length) {
      _languages.removeAt(index);
      notifyListeners();
    }
  }

  void setLanguagesList(List<String> languagesList) {
    _languages = List.from(languagesList);
    notifyListeners();
  }

  // Reset all data
  void reset() {
    _fullName = '';
    _email = '';
    _phone = '';
    _address = '';
    _profileSummary = '';
    _education = [];
    _workExperience = [];
    _skills = [];
    _certifications = [];
    _languages = [];
    notifyListeners();
  }
}