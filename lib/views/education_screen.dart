// views/education_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../models/education.dart';
import '../view_models/cv_view_model.dart';
import '../view_models/education_view_model.dart';

class EducationScreen extends StatefulWidget {
  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // CV verilerini education ViewModel'e aktar
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    final educationViewModel = Provider.of<EducationViewModel>(context, listen: false);
    
    // EducationViewModel'i CV verilerinden doldur
    if (cvViewModel.cvData.education.isNotEmpty) {
      educationViewModel.setEducationList(cvViewModel.cvData.education);
    }
  }
  
  @override
  void dispose() {
    _schoolController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final educationViewModel = Provider.of<EducationViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.educationTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eğitim Geçmişi',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text(
                'Eğitim bilgilerinizi ekleyin. Birden fazla eğitim bilgisi girebilirsiniz.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              
              // Eğitim formu
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Okul
                    TextFormField(
                      controller: _schoolController,
                      decoration: InputDecoration(
                        labelText: 'Okul / Üniversite',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school),
                      ),
                      validator: Validators.validateSchool,
                    ),
                    SizedBox(height: 16),
                    
                    // Derece
                    TextFormField(
                      controller: _degreeController,
                      decoration: InputDecoration(
                        labelText: 'Derece (Lisans, Yüksek Lisans vb.)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.grade),
                      ),
                      validator: Validators.validateDegree,
                    ),
                    SizedBox(height: 16),
                    
                    // Alan
                    TextFormField(
                      controller: _fieldOfStudyController,
                      decoration: InputDecoration(
                        labelText: 'Alan / Bölüm',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.subject),
                      ),
                      validator: Validators.validateRequired,
                    ),
                    SizedBox(height: 16),
                    
                    // Başlangıç ve Bitiş Tarihi
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _startDateController,
                            decoration: InputDecoration(
                              labelText: 'Başlangıç Tarihi',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'Ör: 09/2015',
                            ),
                            validator: Validators.validateDate,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _endDateController,
                            decoration: InputDecoration(
                              labelText: 'Bitiş Tarihi',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'Ör: 06/2019 veya "Devam Ediyor"',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    
                    // Ekle butonu
                    ElevatedButton.icon(
                      onPressed: _addEducation,
                      icon: Icon(Icons.add),
                      label: Text('Eğitim Bilgisi Ekle'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Eklenen eğitim listesi
              if (educationViewModel.educationList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eklenen Eğitim Bilgileri',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...educationViewModel.educationList.asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        Education education = entry.value;
                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(
                              '${education.degree} - ${education.fieldOfStudy}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${education.school}\n${education.startDate} - ${education.endDate}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editEducation(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteEducation(index),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
              
              SizedBox(height: 32),
              
              // Devam Et butonu
              Center(
                child: ElevatedButton(
                  onPressed: _saveAndContinue,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: Text(
                    AppStrings.continueButton,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Eğitim bilgisi ekleme
  void _addEducation() {
    if (_formKey.currentState!.validate()) {
      final educationViewModel = Provider.of<EducationViewModel>(context, listen: false);
      
      Education education = Education(
        school: _schoolController.text,
        degree: _degreeController.text,
        fieldOfStudy: _fieldOfStudyController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text.isEmpty ? 'Devam Ediyor' : _endDateController.text,
      );
      
      educationViewModel.addEducation(education);
      
      // Form alanlarını temizle
      _schoolController.clear();
      _degreeController.clear();
      _fieldOfStudyController.clear();
      _startDateController.clear();
      _endDateController.clear();
    }
  }
  
  // Eğitim bilgisi düzenleme
  void _editEducation(int index) {
    final educationViewModel = Provider.of<EducationViewModel>(context, listen: false);
    Education education = educationViewModel.educationList[index];
    
    // Form alanlarını doldur
    _schoolController.text = education.school;
    _degreeController.text = education.degree;
    _fieldOfStudyController.text = education.fieldOfStudy;
    _startDateController.text = education.startDate;
    _endDateController.text = education.endDate == 'Devam Ediyor' ? '' : education.endDate;
    
    // Eğitim bilgisini listeden kaldır (düzenleme için)
    educationViewModel.removeEducation(index);
  }
  
  // Eğitim bilgisi silme
  void _deleteEducation(int index) {
    final educationViewModel = Provider.of<EducationViewModel>(context, listen: false);
    educationViewModel.removeEducation(index);
  }
  
  // Kaydet ve devam et
  void _saveAndContinue() {
    final educationViewModel = Provider.of<EducationViewModel>(context, listen: false);
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    
    // Eğitim bilgilerini CV verilerine aktar
    cvViewModel.setEducationList(educationViewModel.educationList);
    
    // İş deneyimi ekranına geç
    Navigator.pushNamed(context, AppRoutes.workExperience);
  }
}