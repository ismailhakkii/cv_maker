// views/preview_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import '../utils/constants.dart';
import '../services/template_service.dart';
import '../services/pdf_service.dart';
import '../view_models/cv_view_model.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool _isLoading = true;
  String _htmlContent = '';
  late WebViewController _webViewController;
  
  @override
  void initState() {
    super.initState();
    _generateHtmlPreview();
  }
  
  // HTML içeriğini oluştur
  Future<void> _generateHtmlPreview() async {
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    
    try {
      String html = await TemplateService.generateHtml(cvViewModel.cvData);
      setState(() {
        _htmlContent = html;
        _isLoading = false;
      });
    } catch (e) {
      print('HTML oluşturma hatası: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('CV önizlemesi oluşturulamadı: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.previewTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: _savePDF,
            tooltip: 'PDF Olarak Kaydet',
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'CV Önizleme',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildWebView(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: _savePDF,
                      icon: Icon(Icons.save_alt),
                      label: Text(AppStrings.saveAndShareButton),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
  
  Widget _buildWebView() {
    // WebView için controller oluştur
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            print('Sayfa yüklendi: $url');
          },
        ),
      )
      ..loadHtmlString(_htmlContent);
    
    // WebView widget'ını döndür
    return WebViewWidget(controller: _webViewController);
  }
  
  // PDF olarak kaydetme
  void _savePDF() async {
    final cvViewModel = Provider.of<CVViewModel>(context, listen: false);
    await PDFService.generateAndSharePDF(context, cvViewModel.cvData);
  }
}