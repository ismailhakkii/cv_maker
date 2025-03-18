// view_models/skills_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/skill.dart';

class SkillsViewModel with ChangeNotifier {
  List<Skill> _skillsList = [];
  Skill _currentSkill = Skill(name: '', level: 3);
  List<String> _certificationsList = [];
  List<String> _languagesList = [];
  
  // Getters
  List<Skill> get skillsList => List.unmodifiable(_skillsList);
  Skill get currentSkill => _currentSkill;
  List<String> get certificationsList => List.unmodifiable(_certificationsList);
  List<String> get languagesList => List.unmodifiable(_languagesList);
  
  // Yetenek ekleme
  void addSkill(Skill skill) {
    _skillsList.add(skill);
    // Yeni bir boş yetenek oluştur
    _currentSkill = Skill(name: '', level: 3);
    notifyListeners();
  }
  
  // Yetenek silme
  void removeSkill(int index) {
    if (index >= 0 && index < _skillsList.length) {
      _skillsList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm yetenekleri ayarlama
  void setSkillsList(List<Skill> skillsList) {
    _skillsList = List.from(skillsList);
    notifyListeners();
  }
  
  // Mevcut yeteneği güncelleme
  void updateCurrentSkill({
    String? name,
    int? level,
  }) {
    _currentSkill = _currentSkill.copyWith(
      name: name,
      level: level,
    );
    notifyListeners();
  }
  
  // Mevcut yeteneği sıfırlama
  void resetCurrentSkill() {
    _currentSkill = Skill(name: '', level: 3);
    notifyListeners();
  }
  
  // Var olan bir yeteneği düzenleme
  void editSkill(int index) {
    if (index >= 0 && index < _skillsList.length) {
      _currentSkill = _skillsList[index];
      _skillsList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Sertifika ekleme
  void addCertification(String certification) {
    _certificationsList.add(certification);
    notifyListeners();
  }
  
  // Sertifika silme
  void removeCertification(int index) {
    if (index >= 0 && index < _certificationsList.length) {
      _certificationsList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm sertifikaları ayarlama
  void setCertificationsList(List<String> certificationsList) {
    _certificationsList = List.from(certificationsList);
    notifyListeners();
  }
  
  // Dil ekleme
  void addLanguage(String language) {
    _languagesList.add(language);
    notifyListeners();
  }
  
  // Dil silme
  void removeLanguage(int index) {
    if (index >= 0 && index < _languagesList.length) {
      _languagesList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm dilleri ayarlama
  void setLanguagesList(List<String> languagesList) {
    _languagesList = List.from(languagesList);
    notifyListeners();
  }
  
  // Tüm verileri temizle
  void clear() {
    _skillsList = [];
    resetCurrentSkill();
    _certificationsList = [];
    _languagesList = [];
    notifyListeners();
  }
}