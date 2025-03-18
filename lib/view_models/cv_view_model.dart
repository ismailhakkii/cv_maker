// view_models/cv_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/cv_data.dart';
import '../models/education.dart';
import '../models/work_experience.dart';
import '../models/skill.dart';

class CVViewModel with ChangeNotifier {
  late CVData _cvData;
  bool _isLoading = false;
  String? _errorMessage;
  
  // Getters
  CVData get cvData => _cvData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  // Constructor
  CVViewModel(String templateId) {
    _cvData = CVData(templateId: templateId);
    
    // Listen to changes in the model to propagate notifications
    _cvData.addListener(() {
      notifyListeners();
    });
  }
  
  // Methods to update personal information
  void updatePersonalInfo({
    String? fullName,
    String? email,
    String? phone,
    String? address,
    String? profileSummary,
  }) {
    if (fullName != null) _cvData.fullName = fullName;
    if (email != null) _cvData.email = email;
    if (phone != null) _cvData.phone = phone;
    if (address != null) _cvData.address = address;
    if (profileSummary != null) _cvData.profileSummary = profileSummary;
  }
  
  // Methods for education
  void addEducation(Education education) {
    _cvData.addEducation(education);
  }
  
  void removeEducation(int index) {
    _cvData.removeEducation(index);
  }
  
  void setEducationList(List<Education> educationList) {
    _cvData.setEducationList(educationList);
  }
  
  // Methods for work experience
  void addWorkExperience(WorkExperience experience) {
    _cvData.addWorkExperience(experience);
  }
  
  void removeWorkExperience(int index) {
    _cvData.removeWorkExperience(index);
  }
  
  void setWorkExperienceList(List<WorkExperience> experienceList) {
    _cvData.setWorkExperienceList(experienceList);
  }
  
  // Methods for skills
  void addSkill(Skill skill) {
    _cvData.addSkill(skill);
  }
  
  void removeSkill(int index) {
    _cvData.removeSkill(index);
  }
  
  void setSkillsList(List<Skill> skillsList) {
    _cvData.setSkillsList(skillsList);
  }
  
  // Methods for certifications
  void addCertification(String certification) {
    _cvData.addCertification(certification);
  }
  
  void removeCertification(int index) {
    _cvData.removeCertification(index);
  }
  
  void setCertificationsList(List<String> certificationsList) {
    _cvData.setCertificationsList(certificationsList);
  }
  
  // Methods for languages
  void addLanguage(String language) {
    _cvData.addLanguage(language);
  }
  
  void removeLanguage(int index) {
    _cvData.removeLanguage(index);
  }
  
  void setLanguagesList(List<String> languagesList) {
    _cvData.setLanguagesList(languagesList);
  }
  
  // Method to handle loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  // Method to handle errors
  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
  
  // Reset CV data
  void resetCVData() {
    _cvData.reset();
  }
  
  @override
  void dispose() {
    _cvData.dispose();
    super.dispose();
  }
}