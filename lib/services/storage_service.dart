// services/storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cv_data.dart';
import '../models/education.dart';
import '../models/work_experience.dart';
import '../models/skill.dart';

class StorageService {
  static const String CV_DATA_KEY = 'cv_data';
  
  // CV verilerini kaydetme
  static Future<bool> saveCVData(CVData cvData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // CV verilerini Map'e dönüştür
      Map<String, dynamic> cvDataMap = {
        'templateId': cvData.templateId,
        'fullName': cvData.fullName,
        'email': cvData.email,
        'phone': cvData.phone,
        'address': cvData.address,
        'profileSummary': cvData.profileSummary,
        'education': cvData.education.map((e) => e.toMap()).toList(),
        'workExperience': cvData.workExperience.map((e) => e.toMap()).toList(),
        'skills': cvData.skills.map((e) => e.toMap()).toList(),
        'certifications': cvData.certifications,
        'languages': cvData.languages,
      };
      
      // Map'i JSON String'e dönüştür ve kaydet
      String cvDataJson = jsonEncode(cvDataMap);
      return await prefs.setString(CV_DATA_KEY, cvDataJson);
    } catch (e) {
      print('CV verisi kaydedilemedi: $e');
      return false;
    }
  }
  
  // Kaydedilmiş CV verilerini yükleme
  static Future<CVData?> loadCVData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? cvDataJson = prefs.getString(CV_DATA_KEY);
      
      if (cvDataJson == null) {
        return null;
      }
      
      // JSON String'i Map'e dönüştür
      Map<String, dynamic> cvDataMap = jsonDecode(cvDataJson);
      
      // Yeni CVData objesi oluştur
      CVData cvData = CVData(templateId: cvDataMap['templateId'] ?? '');
      
      // Basit değerleri ata
      cvData.fullName = cvDataMap['fullName'] ?? '';
      cvData.email = cvDataMap['email'] ?? '';
      cvData.phone = cvDataMap['phone'] ?? '';
      cvData.address = cvDataMap['address'] ?? '';
      cvData.profileSummary = cvDataMap['profileSummary'] ?? '';
      
      // Eğitim listesini oluştur
      if (cvDataMap['education'] != null) {
        List<dynamic> eduList = cvDataMap['education'];
        cvData.setEducationList(
          eduList.map((e) => Education.fromMap(e)).toList()
        );
      }
      
      // İş deneyimi listesini oluştur
      if (cvDataMap['workExperience'] != null) {
        List<dynamic> expList = cvDataMap['workExperience'];
        cvData.setWorkExperienceList(
          expList.map((e) => WorkExperience.fromMap(e)).toList()
        );
      }
      
      // Yetenekler listesini oluştur
      if (cvDataMap['skills'] != null) {
        List<dynamic> skillList = cvDataMap['skills'];
        cvData.setSkillsList(
          skillList.map((e) => Skill.fromMap(e)).toList()
        );
      }
      
      // Sertifikalar ve diller listelerini oluştur
      if (cvDataMap['certifications'] != null) {
        List<dynamic> certList = cvDataMap['certifications'];
        cvData.setCertificationsList(
          certList.map((e) => e.toString()).toList()
        );
      }
      
      if (cvDataMap['languages'] != null) {
        List<dynamic> langList = cvDataMap['languages'];
        cvData.setLanguagesList(
          langList.map((e) => e.toString()).toList()
        );
      }
      
      return cvData;
    } catch (e) {
      print('CV verisi yüklenemedi: $e');
      return null;
    }
  }
  
  // CV verilerini temizleme
  static Future<bool> clearCVData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(CV_DATA_KEY);
    } catch (e) {
      print('CV verisi temizlenemedi: $e');
      return false;
    }
  }
}