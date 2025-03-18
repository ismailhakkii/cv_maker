// services/pdf_service.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../models/cv_data.dart';
import 'template_service.dart';

class PDFService {
  // HTML'i PDF'e dönüştürme ve paylaşma
  static Future<void> generateAndSharePDF(BuildContext context, CVData cvData) async {
    try {
      // PDF oluştur
      final pdf = pw.Document();
      
      // HTML içeriğini al
      String html = await TemplateService.generateHtml(cvData);
      
      // HTML içeriğini PDF'e dönüştür
      final pdfBytes = await Printing.convertHtml(
        format: PdfPageFormat.a4,
        html: html,
      );
      
      // Geçici dosya oluştur
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = "${cvData.fullName.replaceAll(' ', '_')}_CV.pdf";
      final File pdfFile = File('${directory.path}/$fileName');
      
      // PDF'i kaydet
      await pdfFile.writeAsBytes(pdfBytes);
      
      // PDF'i paylaş
      await Share.shareFiles([pdfFile.path], text: 'CV');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF kaydedildi ve paylaşıldı')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }
}