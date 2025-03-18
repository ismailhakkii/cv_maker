// view_models/work_experience_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/work_experience.dart';

class WorkExperienceViewModel with ChangeNotifier {
  List<WorkExperience> _experienceList = [];
  WorkExperience _currentExperience = WorkExperience(
    company: '',
    position: '',
    startDate: '',
    endDate: '',
    description: '',
  );
  
  // Getters
  List<WorkExperience> get experienceList => List.unmodifiable(_experienceList);
  WorkExperience get currentExperience => _currentExperience;
  
  // İş deneyimi ekleme
  void addWorkExperience(WorkExperience experience) {
    _experienceList.add(experience);
    // Yeni bir boş iş deneyimi oluştur
    _currentExperience = WorkExperience(
      company: '',
      position: '',
      startDate: '',
      endDate: '',
      description: '',
    );
    notifyListeners();
  }
  
  // İş deneyimi silme
  void removeWorkExperience(int index) {
    if (index >= 0 && index < _experienceList.length) {
      _experienceList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm iş deneyimlerini ayarlama
  void setWorkExperienceList(List<WorkExperience> experienceList) {
    _experienceList = List.from(experienceList);
    notifyListeners();
  }
  
  // Mevcut iş deneyimini güncelleme
  void updateCurrentExperience({
    String? company,
    String? position,
    String? startDate,
    String? endDate,
    String? description,
  }) {
    _currentExperience = _currentExperience.copyWith(
      company: company,
      position: position,
      startDate: startDate,
      endDate: endDate,
      description: description,
    );
    notifyListeners();
  }
  
  // Mevcut iş deneyimini sıfırlama
  void resetCurrentExperience() {
    _currentExperience = WorkExperience(
      company: '',
      position: '',
      startDate: '',
      endDate: '',
      description: '',
    );
    notifyListeners();
  }
  
  // Var olan bir iş deneyimini düzenleme
  void editWorkExperience(int index) {
    if (index >= 0 && index < _experienceList.length) {
      _currentExperience = _experienceList[index];
      _experienceList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm verileri temizle
  void clear() {
    _experienceList = [];
    resetCurrentExperience();
  }
}