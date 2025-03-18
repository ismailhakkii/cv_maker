// views/work_experience_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../models/work_experience.dart';
import '../view_models/cv_view_model.dart';
import '../view_models/work_experience_view_model.dart';

class WorkExperienceScreen extends StatefulWidget {
  @override
  _WorkExperienceScreenState createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // CV verilerini work experience ViewModel'e aktar
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    final workExperienceViewModel = Provider.of<WorkExperienceViewModel>(context, listen: false);
    
    // WorkExperienceViewModel'i CV verilerinden doldur
    if (cvViewModel.cvData.workExperience.isNotEmpty) {
      workExperienceViewModel.setWorkExperienceList(cvViewModel.cvData.workExperience);
    }
  }
  
  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final workExperienceViewModel = Provider.of<WorkExperienceViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.workExperienceTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'İş Deneyimleriniz',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text(
                'İş deneyimlerinizi ekleyin. Birden fazla iş deneyimi girebilirsiniz.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              
              // İş deneyimi formu
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Şirket
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: 'Şirket',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                      ),
                      validator: Validators.validateCompany,
                    ),
                    SizedBox(height: 16),
                    
                    // Pozisyon
                    TextFormField(
                      controller: _positionController,
                      decoration: InputDecoration(
                        labelText: 'Pozisyon',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                      ),
                      validator: Validators.validatePosition,
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
                              hintText: 'Ör: 09/2018',
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
                              hintText: 'Ör: 06/2022 veya "Devam Ediyor"',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // İş Tanımı
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'İş Tanımı',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                      validator: Validators.validateRequired,
                    ),
                    SizedBox(height: 24),
                    
                    // Ekle butonu
                    ElevatedButton.icon(
                      onPressed: _addWorkExperience,
                      icon: Icon(Icons.add),
                      label: Text('İş Deneyimi Ekle'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Eklenen iş deneyimi listesi
              if (workExperienceViewModel.experienceList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eklenen İş Deneyimleri',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...workExperienceViewModel.experienceList.asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        WorkExperience experience = entry.value;
                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(
                              '${experience.position} - ${experience.company}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${experience.startDate} - ${experience.endDate}\n${experience.description}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editWorkExperience(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteWorkExperience(index),
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
  
  // İş deneyimi ekleme
  void _addWorkExperience() {
    if (_formKey.currentState!.validate()) {
      final workExperienceViewModel = Provider.of<WorkExperienceViewModel>(context, listen: false);
      
      WorkExperience experience = WorkExperience(
        company: _companyController.text,
        position: _positionController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text.isEmpty ? 'Devam Ediyor' : _endDateController.text,
        description: _descriptionController.text,
      );
      
      workExperienceViewModel.addWorkExperience(experience);
      
      // Form alanlarını temizle
      _companyController.clear();
      _positionController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _descriptionController.clear();
    }
  }
  
  // İş deneyimi düzenleme
  void _editWorkExperience(int index) {
    final workExperienceViewModel = Provider.of<WorkExperienceViewModel>(context, listen: false);
    WorkExperience experience = workExperienceViewModel.experienceList[index];
    
    // Form alanlarını doldur
    _companyController.text = experience.company;
    _positionController.text = experience.position;
    _startDateController.text = experience.startDate;
    _endDateController.text = experience.endDate == 'Devam Ediyor' ? '' : experience.endDate;
    _descriptionController.text = experience.description;
    
    // İş deneyimini listeden kaldır (düzenleme için)
    workExperienceViewModel.removeWorkExperience(index);
  }
  
  // İş deneyimi silme
  void _deleteWorkExperience(int index) {
    final workExperienceViewModel = Provider.of<WorkExperienceViewModel>(context, listen: false);
    workExperienceViewModel.removeWorkExperience(index);
  }
  
  // Kaydet ve devam et
  void _saveAndContinue() {
    final workExperienceViewModel = Provider.of<WorkExperienceViewModel>(context, listen: false);
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    
    // İş deneyimlerini CV verilerine aktar
    cvViewModel.setWorkExperienceList(workExperienceViewModel.experienceList);
    
    // Yetenekler ekranına geç
    Navigator.pushNamed(context, AppRoutes.skills);
  }
}