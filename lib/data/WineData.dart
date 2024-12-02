import 'dart:convert';
import 'package:flutter/services.dart';

class WineData {
  static const Map<String, List<Map<String, String>>> wineCategories = {
    'Type': [
      {'name': 'Red Wine', 'image': 'assets/redwine.png'},
      {'name': 'White Wine', 'image': 'assets/redwine.png'},
      {'name': 'Rose Wine', 'image': 'assets/redwine.png'},
    ],
    'Style': [
      {'name': 'Sparkling Wine', 'image': 'assets/redwine.png'},
      {'name': 'Light-Bodied White Wine', 'image': 'assets/redwine.png'},
      {'name': 'Full-Bodied White Wine', 'image': 'assets/redwine.png'},
    ],
    'Countries': [
      {'name': 'Moldova', 'image': 'assets/redwine.png'},
      {'name': 'France', 'image': 'assets/redwine.png'},
      {'name': 'Romania', 'image': 'assets/redwine.png'},
    ],
    'Grape': [
      {'name': 'Pinot Noir', 'image': 'assets/redwine.png'},
      {'name': 'Cabernet Sauvignon', 'image': 'assets/redwine.png'},
      {'name': 'Chardonnay', 'image': 'assets/redwine.png'},
    ],
  };

  static Future<List<Map<String, dynamic>>> loadWineData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/v3.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      if (jsonData['carousel'] is List) {
        return List<Map<String, dynamic>>.from(jsonData['carousel']);
      } else {
        print('Cheia "carousel" nu este o listă validă.');
        return [];
      }
    } catch (e) {
      print('Eroare la încărcarea datelor din JSON: $e');
      return [];
    }
  }
}
