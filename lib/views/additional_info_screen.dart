// views/additional_info_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../view_models/cv_view_model.dart';
import '../view_models/skills_view_model.dart';

class AdditionalInfoScreen extends StatefulWidget {
  @override
  _AdditionalInfoScreenState createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  final TextEditingController _certificationController = TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // CV verilerini skills ViewModel'e aktar
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
    
    // SkillsViewModel'i CV verilerinden doldur
    if (cvViewModel.cvData.certifications.isNotEmpty) {
      skillsViewModel.setCertificationsList(cvViewModel.cvData.certifications);
    }
    
    if (cvViewModel.cvData.languages.isNotEmpty) {
      skillsViewModel.setLanguagesList(cvViewModel.cvData.languages);
    }
  }
  
  @override
  void dispose() {
    _certificationController.dispose();
    _languageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final skillsViewModel = Provider.of<SkillsViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.additionalInfoTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ek Bilgiler',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text(
                'Sertifikalarınızı ve bildiğiniz dilleri ekleyin (isteğe bağlı).',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              
              // Sertifikalar
              Text(
                'Sertifikalar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _certificationController,
                      decoration: InputDecoration(
                        labelText: 'Sertifika Adı',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.card_membership),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_certificationController.text.trim().isNotEmpty) {
                        skillsViewModel.addCertification(_certificationController.text.trim());
                        _certificationController.clear();
                      }
                    },
                    child: Text('Ekle'),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (skillsViewModel.certificationsList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    ...skillsViewModel.certificationsList.asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        String certification = entry.value;
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(Icons.card_membership, color: AppColors.accent),
                            title: Text(certification),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                skillsViewModel.removeCertification(index);
                              },
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              
              SizedBox(height: 32),
              
              // Diller
              Text(
                'Diller',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _languageController,
                      decoration: InputDecoration(
                        labelText: 'Dil ve Seviye (örn: İngilizce - İleri)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.language),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_languageController.text.trim().isNotEmpty) {
                        skillsViewModel.addLanguage(_languageController.text.trim());
                        _languageController.clear();
                      }
                    },
                    child: Text('Ekle'),
                  ),
                ],
              ),
              SizedBox(height: 8),
              if (skillsViewModel.languagesList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    ...skillsViewModel.languagesList.asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        String language = entry.value;
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(Icons.language, color: AppColors.accent),
                            title: Text(language),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                skillsViewModel.removeLanguage(index);
                              },
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              
              SizedBox(height: 40),
              
              // CV Önizleme butonu
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveAndPreview,
                  icon: Icon(Icons.visibility),
                  label: Text(
                    AppStrings.previewButton,
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Kaydet ve önizle
  void _saveAndPreview() {
    final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    
    // Sertifika ve dil verilerini CV verilerine aktar
    cvViewModel.setCertificationsList(skillsViewModel.certificationsList);
    cvViewModel.setLanguagesList(skillsViewModel.languagesList);
    
    // Önizleme ekranına geç
    Navigator.pushNamed(context, AppRoutes.preview);
  }
}