// views/skills_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../models/skill.dart';
import '../view_models/cv_view_model.dart';
import '../view_models/skills_view_model.dart';

class SkillsScreen extends StatefulWidget {
  @override
  _SkillsScreenState createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _skillNameController = TextEditingController();
  int _skillLevel = 3;
  
  @override
  void initState() {
    super.initState();
    
    // CV verilerini skills ViewModel'e aktar
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
    
    // SkillsViewModel'i CV verilerinden doldur
    if (cvViewModel.cvData.skills.isNotEmpty) {
      skillsViewModel.setSkillsList(cvViewModel.cvData.skills);
    }
  }
  
  @override
  void dispose() {
    _skillNameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final skillsViewModel = Provider.of<SkillsViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.skillsTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yetenekleriniz',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text(
                'Teknik ve profesyonel yeteneklerinizi ekleyin ve seviyesini belirtin.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              
              // Yetenekler formu
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Yetenek adı
                    TextFormField(
                      controller: _skillNameController,
                      decoration: InputDecoration(
                        labelText: 'Yetenek Adı',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.psychology),
                      ),
                      validator: Validators.validateSkillName,
                    ),
                    SizedBox(height: 16),
                    
                    // Yetenek seviyesi
                    Text(
                      'Seviye: $_skillLevel',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_border, color: Colors.amber),
                        Expanded(
                          child: Slider(
                            value: _skillLevel.toDouble(),
                            min: 1,
                            max: 5,
                            divisions: 4,
                            label: _skillLevel.toString(),
                            onChanged: (double value) {
                              setState(() {
                                _skillLevel = value.round();
                              });
                            },
                          ),
                        ),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    SizedBox(height: 24),
                    
                    // Ekle butonu
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _addSkill,
                        icon: Icon(Icons.add),
                        label: Text('Yetenek Ekle'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Eklenen yetenekler listesi
              if (skillsViewModel.skillsList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eklenen Yetenekler',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...skillsViewModel.skillsList.asMap().entries.map(
                      (entry) {
                        int index = entry.key;
                        Skill skill = entry.value;
                        return Card(
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(
                              skill.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < skill.level ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editSkill(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteSkill(index),
                                ),
                              ],
                            ),
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
  
  // Yetenek ekleme
  void _addSkill() {
    if (_formKey.currentState!.validate()) {
      final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
      
      Skill skill = Skill(
        name: _skillNameController.text,
        level: _skillLevel,
      );
      
      skillsViewModel.addSkill(skill);
      
      // Form alanlarını temizle
      _skillNameController.clear();
      setState(() {
        _skillLevel = 3;
      });
    }
  }
  
  // Yetenek düzenleme
  void _editSkill(int index) {
    final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
    Skill skill = skillsViewModel.skillsList[index];
    
    // Form alanlarını doldur
    _skillNameController.text = skill.name;
    setState(() {
      _skillLevel = skill.level;
    });
    
    // Yeteneği listeden kaldır (düzenleme için)
    skillsViewModel.removeSkill(index);
  }
  
  // Yetenek silme
  void _deleteSkill(int index) {
    final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
    skillsViewModel.removeSkill(index);
  }
  
  // Kaydet ve devam et
  void _saveAndContinue() {
    final skillsViewModel = Provider.of<SkillsViewModel>(context, listen: false);
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    
    // Yetenekleri CV verilerine aktar
    cvViewModel.setSkillsList(skillsViewModel.skillsList);
    
    // Ek bilgiler ekranına geç
    Navigator.pushNamed(context, AppRoutes.additionalInfo);
  }
}