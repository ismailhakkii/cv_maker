// view_models/education_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/education.dart';

class EducationViewModel with ChangeNotifier {
  List<Education> _educationList = [];
  Education _currentEducation = Education(
    school: '',
    degree: '',
    fieldOfStudy: '',
    startDate: '',
    endDate: '',
  );
  
  // Getters
  List<Education> get educationList => List.unmodifiable(_educationList);
  Education get currentEducation => _currentEducation;
  
  // Eğitim bilgisi ekleme
  void addEducation(Education education) {
    _educationList.add(education);
    // Yeni bir boş eğitim oluştur
    _currentEducation = Education(
      school: '',
      degree: '',
      fieldOfStudy: '',
      startDate: '',
      endDate: '',
    );
    notifyListeners();
  }
  
  // Eğitim bilgisi silme
  void removeEducation(int index) {
    if (index >= 0 && index < _educationList.length) {
      _educationList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm eğitim bilgilerini ayarlama
  void setEducationList(List<Education> educationList) {
    _educationList = List.from(educationList);
    notifyListeners();
  }
  
  // Mevcut eğitim bilgisini güncelleme
  void updateCurrentEducation({
    String? school,
    String? degree,
    String? fieldOfStudy,
    String? startDate,
    String? endDate,
  }) {
    _currentEducation = _currentEducation.copyWith(
      school: school,
      degree: degree,
      fieldOfStudy: fieldOfStudy,
      startDate: startDate,
      endDate: endDate,
    );
    notifyListeners();
  }
  
  // Mevcut eğitim bilgisini sıfırlama
  void resetCurrentEducation() {
    _currentEducation = Education(
      school: '',
      degree: '',
      fieldOfStudy: '',
      startDate: '',
      endDate: '',
    );
    notifyListeners();
  }
  
  // Var olan bir eğitim bilgisini düzenleme
  void editEducation(int index) {
    if (index >= 0 && index < _educationList.length) {
      _currentEducation = _educationList[index];
      _educationList.removeAt(index);
      notifyListeners();
    }
  }
  
  // Tüm verileri temizle
  void clear() {
    _educationList = [];
    resetCurrentEducation();
  }
}