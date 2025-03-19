// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cv_maker/utils/constants.dart';
import 'package:cv_maker/view_models/cv_view_model.dart';
import 'package:cv_maker/view_models/education_view_model.dart';
import 'package:cv_maker/view_models/work_experience_view_model.dart';
import 'package:cv_maker/view_models/skills_view_model.dart';
import 'package:cv_maker/views/welcome_screen.dart';
import 'package:cv_maker/views/template_selection_screen.dart';
import 'package:cv_maker/views/personal_info_screen.dart';
import 'package:cv_maker/views/education_screen.dart';
import 'package:cv_maker/views/work_experience_screen.dart';
import 'package:cv_maker/views/skills_screen.dart';
import 'package:cv_maker/views/additional_info_screen.dart';
import 'package:cv_maker/views/preview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CVViewModel('')),
        ChangeNotifierProvider(create: (_) => EducationViewModel()),
        ChangeNotifierProvider(create: (_) => WorkExperienceViewModel()),
        ChangeNotifierProvider(create: (_) => SkillsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.welcome,
        routes: {
          AppRoutes.welcome: (context) => WelcomeScreen(),
          AppRoutes.templateSelection: (context) => TemplateSelectionScreen(),
          AppRoutes.personalInfo: (context) => PersonalInfoScreen(),
          AppRoutes.education: (context) => EducationScreen(),
          AppRoutes.workExperience: (context) => WorkExperienceScreen(),
          AppRoutes.skills: (context) => SkillsScreen(),
          AppRoutes.additionalInfo: (context) => AdditionalInfoScreen(),
          AppRoutes.preview: (context) => PreviewScreen(),
        },
      ),
    );
  }
}