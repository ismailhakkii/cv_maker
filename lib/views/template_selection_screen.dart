// views/template_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../services/template_service.dart';
import '../view_models/cv_view_model.dart';

class TemplateSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Şablon bilgilerini al
    final templates = TemplateService.getTemplates();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.templateSelectionTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CV Şablonu Seçin',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text(
                'CV\'nizin görünümünü belirlemek için bir şablon seçin.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    final template = templates[index];
                    return _buildTemplateItem(context, template);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTemplateItem(BuildContext context, Map<String, dynamic> template) {
    return GestureDetector(
      onTap: () {
        // Seçilen şablona göre yeni bir CV ViewModel oluştur
        final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
        // ViewModel'i baştan oluşturmak yerine template ID'sini güncelle
        cvViewModel.cvData.templateId = template['id'];
        
        // Kişisel bilgiler ekranına geç
        Navigator.pushNamed(context, AppRoutes.personalInfo);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.description,
                    size: 50,
                    color: AppColors.primary,
                  ),
                ),
                // Gerçek bir uygulamada, burada şablon önizleme görseli olacak
                // Image.asset(template['image'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tıklayın ve seçin',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}