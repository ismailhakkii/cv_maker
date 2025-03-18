// utils/extensions.dart
import 'package:flutter/material.dart';

// String uzantıları
extension StringExtension on String {
  // İlk harfi büyük yapma
  String capitalize() {
    if (this.isEmpty) return this;
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
  
  // Her kelimenin ilk harfini büyük yapma
  String toTitleCase() {
    if (this.isEmpty) return this;
    return this.split(' ').map((word) => word.capitalize()).join(' ');
  }
  
  // Metin içindeki HTML karakterlerini kaçış karakterlerine dönüştürme
  String escapeHtml() {
    return this
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');
  }
}

// DateTime uzantıları
extension DateTimeExtension on DateTime {
  // Ay ve yıl formatında tarih
  String toMonthYearFormat() {
    final months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    
    return "${months[this.month - 1]} ${this.year}";
  }
  
  // Gün, ay ve yıl formatında tarih
  String toFullDateFormat() {
    final months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    
    return "${this.day} ${months[this.month - 1]} ${this.year}";
  }
}

// BuildContext uzantıları
extension BuildContextExtension on BuildContext {
  // Medya sorguları için kısa yollar
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  
  // Tema erişimi için kısa yollar
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  // Snackbar gösterme
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  
  // İletişim kutusu gösterme
  Future<bool?> showConfirmDialog(String title, String message) async {
    return await showDialog<bool>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Onay'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}

// List uzantıları
extension ListExtension<T> on List<T> {
  // Listenin boş olup olmadığını kontrol etme
  bool get isNotNullOrEmpty => this != null && this.isNotEmpty;
  
  // Listeyi gruplandırma
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    Map<K, List<T>> map = {};
    for (var element in this) {
      K key = keyFunction(element);
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(element);
    }
    return map;
  }
}