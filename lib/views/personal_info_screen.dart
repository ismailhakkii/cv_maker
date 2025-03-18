// views/personal_info_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../view_models/cv_view_model.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _profileSummaryController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // CV verilerini kontrolcülere yükle
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    _nameController.text = cvViewModel.cvData.fullName;
    _emailController.text = cvViewModel.cvData.email;
    _phoneController.text = cvViewModel.cvData.phone;
    _addressController.text = cvViewModel.cvData.address;
    _profileSummaryController.text = cvViewModel.cvData.profileSummary;
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _profileSummaryController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.personalInfoTitle),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kişisel Bilgileriniz',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 8),
                Text(
                  'CV\'niz için temel bilgilerinizi girin.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 24),
                
                // Ad Soyad
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Ad Soyad',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: Validators.validateRequired,
                ),
                SizedBox(height: 16),
                
                // E-posta
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                SizedBox(height: 16),
                
                // Telefon
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefon',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                SizedBox(height: 16),
                
                // Adres
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Adres',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                
                // Profil Özeti
                TextFormField(
                  controller: _profileSummaryController,
                  decoration: InputDecoration(
                    labelText: 'Profil Özeti',
                    border: OutlineInputBorder(),
                    hintText: 'Kendinizi kısaca tanıtın',
                    prefixIcon: Icon(Icons.description),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
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
      ),
    );
  }
  
  // Kaydet ve devam et
  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      // CV verilerini güncelle
      final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
      
      cvViewModel.updatePersonalInfo(
        fullName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        profileSummary: _profileSummaryController.text,
      );
      
      // Eğitim ekranına geç
      Navigator.pushNamed(context, AppRoutes.education);
    }
  }
}