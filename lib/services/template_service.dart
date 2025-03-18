// services/template_service.dart
import '../models/cv_data.dart';

class TemplateService {
  // Şablon bilgilerini içeren sınıf
  static List<Map<String, dynamic>> getTemplates() {
    return [
      {
        'name': 'Modern',
        'image': 'assets/modern_template.png',
        'id': 'modern',
      },
      {
        'name': 'Klasik',
        'image': 'assets/classic_template.png',
        'id': 'classic',
      },
      {
        'name': 'Minimalist',
        'image': 'assets/minimalist_template.png',
        'id': 'minimalist',
      },
    ];
  }
  
  // Şablona göre HTML oluşturma
  static Future<String> generateHtml(CVData cvData) async {
    String html = '';
    
    switch (cvData.templateId) {
      case 'modern':
        html = generateModernTemplate(cvData);
        break;
      case 'classic':
        html = generateClassicTemplate(cvData);
        break;
      case 'minimalist':
        html = generateMinimalistTemplate(cvData);
        break;
      default:
        html = generateModernTemplate(cvData);
    }
    
    return html;
  }
  
  // Modern şablon HTML'i oluşturma
  static String generateModernTemplate(CVData cvData) {
    String html = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>${cvData.fullName} - CV</title>
      <style>
        body {
          font-family: 'Arial', sans-serif;
          line-height: 1.6;
          color: #333;
          margin: 0;
          padding: 0;
        }
        
        .container {
          max-width: 800px;
          margin: 0 auto;
          padding: 20px;
        }
        
        .header {
          background: #2c3e50;
          color: white;
          padding: 30px;
          text-align: center;
        }
        
        .header h1 {
          margin: 0;
          font-size: 36px;
        }
        
        .contact-info {
          background: #34495e;
          color: white;
          padding: 15px 30px;
          display: flex;
          justify-content: space-between;
          flex-wrap: wrap;
        }
        
        .contact-info div {
          margin: 5px 0;
        }
        
        .section {
          margin: 30px 0;
        }
        
        .section-title {
          border-bottom: 2px solid #2c3e50;
          padding-bottom: 5px;
          font-size: 22px;
          color: #2c3e50;
        }
        
        .item {
          margin: 20px 0;
        }
        
        .item-title {
          font-weight: bold;
          margin-bottom: 5px;
        }
        
        .item-subtitle {
          font-style: italic;
          color: #7f8c8d;
        }
        
        .item-date {
          color: #95a5a6;
          margin-bottom: 5px;
        }
        
        .item-description {
          margin-top: 5px;
        }
        
        .skills {
          display: flex;
          flex-wrap: wrap;
        }
        
        .skill {
          background: #ecf0f1;
          padding: 5px 10px;
          margin: 5px;
          border-radius: 3px;
        }
        
        .skill-level {
          margin-left: 5px;
          color: #e74c3c;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>${cvData.fullName}</h1>
        </div>
        
        <div class="contact-info">
          ${cvData.email.isNotEmpty ? '<div>Email: ${cvData.email}</div>' : ''}
          ${cvData.phone.isNotEmpty ? '<div>Tel: ${cvData.phone}</div>' : ''}
          ${cvData.address.isNotEmpty ? '<div>Adres: ${cvData.address}</div>' : ''}
        </div>
        
        ${cvData.profileSummary.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Profil</h2>
          <p>${cvData.profileSummary}</p>
        </div>
        ''' : ''}
        
        ${cvData.workExperience.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">İş Deneyimi</h2>
          ${cvData.workExperience.map((exp) => '''
          <div class="item">
            <div class="item-title">${exp.position}</div>
            <div class="item-subtitle">${exp.company}</div>
            <div class="item-date">${exp.startDate} - ${exp.endDate}</div>
            <div class="item-description">${exp.description}</div>
          </div>
          ''').join('')}
        </div>
        ''' : ''}
        
        ${cvData.education.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Eğitim</h2>
          ${cvData.education.map((edu) => '''
          <div class="item">
            <div class="item-title">${edu.degree} - ${edu.fieldOfStudy}</div>
            <div class="item-subtitle">${edu.school}</div>
            <div class="item-date">${edu.startDate} - ${edu.endDate}</div>
          </div>
          ''').join('')}
        </div>
        ''' : ''}
        
        ${cvData.skills.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Yetenekler</h2>
          <div class="skills">
            ${cvData.skills.map((skill) => '''
            <div class="skill">
              ${skill.name}
              <span class="skill-level">${'★' * skill.level}${'☆' * (5 - skill.level)}</span>
            </div>
            ''').join('')}
          </div>
        </div>
        ''' : ''}
        
        ${cvData.certifications.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Sertifikalar</h2>
          <ul>
            ${cvData.certifications.map((cert) => '<li>${cert}</li>').join('')}
          </ul>
        </div>
        ''' : ''}
        
        ${cvData.languages.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Diller</h2>
          <ul>
            ${cvData.languages.map((lang) => '<li>${lang}</li>').join('')}
          </ul>
        </div>
        ''' : ''}
      </div>
    </body>
    </html>
    ''';
    
    return html;
  }
  
  // Klasik şablon HTML'i oluşturma
  static String generateClassicTemplate(CVData cvData) {
    String html = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>${cvData.fullName} - CV</title>
      <style>
        body {
          font-family: 'Times New Roman', serif;
          line-height: 1.5;
          color: #333;
          margin: 0;
          padding: 0;
        }
        
        .container {
          max-width: 800px;
          margin: 0 auto;
          padding: 20px;
          border: 1px solid #ddd;
        }
        
        .header {
          text-align: center;
          border-bottom: 2px solid #000;
          padding-bottom: 20px;
          margin-bottom: 20px;
        }
        
        .header h1 {
          margin: 0;
          font-size: 28px;
          text-transform: uppercase;
        }
        
        .contact-info {
          text-align: center;
          margin-bottom: 20px;
        }
        
        .section {
          margin: 20px 0;
        }
        
        .section-title {
          font-size: 18px;
          text-transform: uppercase;
          border-bottom: 1px solid #000;
          padding-bottom: 5px;
          margin-bottom: 15px;
        }
        
        .item {
          margin: 15px 0;
        }
        
        .item-header {
          display: flex;
          justify-content: space-between;
          margin-bottom: 5px;
        }
        
        .item-title {
          font-weight: bold;
        }
        
        .item-date {
          font-style: italic;
        }
        
        .item-subtitle {
          font-style: italic;
        }
        
        .item-description {
          margin-top: 5px;
        }
        
        .skills-list, .cert-list, .lang-list {
          column-count: 2;
          column-gap: 20px;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>${cvData.fullName}</h1>
        </div>
        
        <div class="contact-info">
          ${cvData.email.isNotEmpty ? '<div>Email: ${cvData.email}</div>' : ''}
          ${cvData.phone.isNotEmpty ? '<div>Tel: ${cvData.phone}</div>' : ''}
          ${cvData.address.isNotEmpty ? '<div>Adres: ${cvData.address}</div>' : ''}
        </div>
        
        ${cvData.profileSummary.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Profil</h2>
          <p>${cvData.profileSummary}</p>
        </div>
        ''' : ''}
        
        ${cvData.education.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Eğitim</h2>
          ${cvData.education.map((edu) => '''
          <div class="item">
            <div class="item-header">
              <div class="item-title">${edu.school}</div>
              <div class="item-date">${edu.startDate} - ${edu.endDate}</div>
            </div>
            <div class="item-subtitle">${edu.degree} - ${edu.fieldOfStudy}</div>
          </div>
          ''').join('')}
        </div>
        ''' : ''}
        
        ${cvData.workExperience.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">İş Deneyimi</h2>
          ${cvData.workExperience.map((exp) => '''
          <div class="item">
            <div class="item-header">
              <div class="item-title">${exp.company}</div>
              <div class="item-date">${exp.startDate} - ${exp.endDate}</div>
            </div>
            <div class="item-subtitle">${exp.position}</div>
            <div class="item-description">${exp.description}</div>
          </div>
          ''').join('')}
        </div>
        ''' : ''}
        
        ${cvData.skills.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Yetenekler</h2>
          <div class="skills-list">
            ${cvData.skills.map((skill) => '''
            <div>${skill.name}: ${'★' * skill.level}${'☆' * (5 - skill.level)}</div>
            ''').join('')}
          </div>
        </div>
        ''' : ''}
        
        ${cvData.certifications.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Sertifikalar</h2>
          <div class="cert-list">
            ${cvData.certifications.map((cert) => '<div>• ${cert}</div>').join('')}
          </div>
        </div>
        ''' : ''}
        
        ${cvData.languages.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Diller</h2>
          <div class="lang-list">
            ${cvData.languages.map((lang) => '<div>• ${lang}</div>').join('')}
          </div>
        </div>
        ''' : ''}
      </div>
    </body>
    </html>
    ''';
    
    return html;
  }
  
  // Minimalist şablon HTML'i oluşturma
  static String generateMinimalistTemplate(CVData cvData) {
    String html = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>${cvData.fullName} - CV</title>
      <style>
        body {
          font-family: 'Helvetica', Arial, sans-serif;
          line-height: 1.6;
          color: #333;
          margin: 0;
          padding: 0;
          background: #f9f9f9;
        }
        
        .container {
          max-width: 800px;
          margin: 20px auto;
          padding: 40px;
          background: white;
          box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .header {
          margin-bottom: 40px;
        }
        
        .header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          font-weight: 300;
          color: #000;
        }
        
        .contact-info {
          color: #666;
          font-size: 14px;
        }
        
        .contact-item {
          margin-right: 20px;
          display: inline-block;
        }
        
        .section {
          margin: 30px 0;
        }
        
        .section-title {
          font-size: 18px;
          color: #000;
          margin-bottom: 15px;
          font-weight: 400;
          text-transform: uppercase;
          letter-spacing: 2px;
        }
        
        .item {
          margin: 25px 0;
          position: relative;
        }
        
        .item-title {
          font-weight: bold;
          margin-bottom: 0;
        }
        
        .item-subtitle {
          color: #666;
          margin-bottom: 5px;
        }
        
        .item-date {
          color: #999;
          font-size: 14px;
          position: absolute;
          right: 0;
          top: 0;
        }
        
        .item-description {
          margin-top: 10px;
          color: #555;
        }
        
        .skills {
          display: flex;
          flex-wrap: wrap;
        }
        
        .skill {
          margin: 0 10px 10px 0;
          font-size: 14px;
        }
        
        .skill-name {
          font-weight: bold;
        }
        
        .skill-level {
          margin-left: 5px;
          color: #999;
        }
        
        ul.simple-list {
          list-style-type: none;
          padding: 0;
          columns: 2;
        }
        
        ul.simple-list li {
          margin-bottom: 5px;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1>${cvData.fullName}</h1>
          <div class="contact-info">
            ${cvData.email.isNotEmpty ? '<span class="contact-item">📧 ${cvData.email}</span>' : ''}
            ${cvData.phone.isNotEmpty ? '<span class="contact-item">📱 ${cvData.phone}</span>' : ''}
            ${cvData.address.isNotEmpty ? '<span class="contact-item">📍 ${cvData.address}</span>' : ''}
          </div>
        </div>
        
        ${cvData.profileSummary.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Hakkımda</h2>
          <p>${cvData.profileSummary}</p>
        </div>
        ''' : ''}
        
        ${cvData.workExperience.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Deneyim</h2>
          ${cvData.workExperience.map((exp) => '''
          <div class="item">
            <h3 class="item-title">${exp.position}</h3>
            <div class="item-subtitle">${exp.company}</div>
            <div class="item-date">${exp.startDate} — ${exp.endDate}</div>
            <div class="item-description">${exp.description}</div>
          </div>
          ''').join('')}
        </div>
        ''' : ''}
        
        ${cvData.education.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Eğitim</h2>
          ${cvData.education.map((edu) => '''
          <div class="item">
            <h3 class="item-title">${edu.degree}</h3>
            <div class="item-subtitle">${edu.school}, ${edu.fieldOfStudy}</div>
            <div class="item-date">${edu.startDate} — ${edu.endDate}</div>
          </div>
          ''').join('')}
        </div>
        ''' : ''}
        
        ${cvData.skills.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Yetenekler</h2>
          <div class="skills">
            ${cvData.skills.map((skill) => '''
            <div class="skill">
              <span class="skill-name">${skill.name}</span>
              <span class="skill-level">${'•' * skill.level}</span>
            </div>
            ''').join('')}
          </div>
        </div>
        ''' : ''}
        
        ${cvData.certifications.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Sertifikalar</h2>
          <ul class="simple-list">
            ${cvData.certifications.map((cert) => '<li>${cert}</li>').join('')}
          </ul>
        </div>
        ''' : ''}
        
        ${cvData.languages.isNotEmpty ? '''
        <div class="section">
          <h2 class="section-title">Diller</h2>
          <ul class="simple-list">
            ${cvData.languages.map((lang) => '<li>${lang}</li>').join('')}
          </ul>
        </div>
        ''' : ''}
      </div>
    </body>
    </html>
    ''';
    
    return html;
  }
}