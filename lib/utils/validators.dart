// utils/validators.dart
class Validators {
  // Boş alan kontrolü
  static String? validateRequired(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'Bu alan zorunludur';
    }
    return null;
  }
  
  // E-posta formatı kontrolü
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'E-posta adresi zorunludur';
    }
    
    // Basit bir e-posta doğrulama ifadesi
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    
    if (!emailRegex.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    
    return null;
  }
  
  // Telefon numarası formatı kontrolü
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Telefon numarası zorunludur';
    }
    
    // Telefon numarası doğrulama ifadesi (basit)
    final phoneRegex = RegExp(r'^[0-9\+\-\(\)\s]{10,15}$');
    
    if (!phoneRegex.hasMatch(value)) {
      return 'Geçerli bir telefon numarası giriniz';
    }
    
    return null;
  }
  
  // Tarih formatı kontrolü
  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tarih zorunludur';
    }
    
    // Eğer "Devam Ediyor" gibi bir değerse kabul et
    if (value.toLowerCase().contains('devam')) {
      return null;
    }
    
    // Basit bir tarih formatı kontrolü (Ay/Yıl veya Ay Yıl veya sadece Yıl)
    final dateRegex = RegExp(r'^(0[1-9]|1[0-2])[\/\s-]?(\d{4}|\d{2})|(\d{4})$');
    
    if (!dateRegex.hasMatch(value)) {
      return 'Geçerli bir tarih formatı giriniz (Ay/Yıl veya Yıl)';
    }
    
    return null;
  }
  
  // Okul adı kontrolü
  static String? validateSchool(String? value) {
    return validateRequired(value, 'Okul adı zorunludur');
  }
  
  // Derece kontrolü
  static String? validateDegree(String? value) {
    return validateRequired(value, 'Derece zorunludur');
  }
  
  // Şirket adı kontrolü
  static String? validateCompany(String? value) {
    return validateRequired(value, 'Şirket adı zorunludur');
  }
  
  // Pozisyon kontrolü
  static String? validatePosition(String? value) {
    return validateRequired(value, 'Pozisyon zorunludur');
  }
  
  // Yetenek adı kontrolü
  static String? validateSkillName(String? value) {
    return validateRequired(value, 'Yetenek adı zorunludur');
  }
}