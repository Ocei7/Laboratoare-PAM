import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(WineShopApp());
}



class WineShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WineShopScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class WineShopScreen extends StatefulWidget {
  @override
  _WineShopScreenState createState() => _WineShopScreenState();
}

class _WineShopScreenState extends State<WineShopScreen> {
  String selectedCategory = 'Type'; // Categoria selectată inițial

  // Date pentru fiecare categorie și imagini asociate
  final Map<String, List<Map<String, String>>> wineCategories = {
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

  // Pentru a controla dacă un vin este adăugat la favorite
  final Map<int, bool> favoriteStatus = {};

  @override
  void initState() {
    super.initState();
    loadWineData();
  }

  List<Map<String, dynamic>> wineList = []; // Lista de vinuri din JSON

  // Încarcă datele din fișierul JSON
  Future<void> loadWineData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/v3.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        // Asigurăm că 'carousel' este un List
        if (jsonData['carousel'] is List) {
          wineList = List<Map<String, dynamic>>.from(jsonData['carousel']);
        } else {
          print('Cheia "carousel" nu este o listă validă.');
          wineList = [];
        }
      });
    } catch (e) {
      print('Eroare la încărcarea datelor din JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Wine Shop', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Aici poți adăuga funcționalitate pentru notificări
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Shop wines by" title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Shop wines by',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Bara de căutare
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Wines...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // "Address" Field

          // Horizontal Scroll for categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: wineCategories.keys.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Display the wines for the selected category
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Afișarea vinurilor specifice categoriilor
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: wineCategories[selectedCategory]!
                            .map((wine) => WineCard(
                          wineName: wine['name']!,
                          wineImage: wine['image']!,
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  // Lista de vinuri din JSON
                  ...List.generate(wineList.length, (index) {
                    final wine = wineList[index];
                    return WineDetailCard(
                      wine: wine,
                      isFavorite: favoriteStatus[index] ?? false,
                      onFavoriteToggled: () {
                        setState(() {
                          favoriteStatus[index] = !(favoriteStatus[index] ?? false);
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card simplu pentru vinuri în categorii
class WineCard extends StatelessWidget {
  final String wineName;
  final String wineImage;

  WineCard({required this.wineName, required this.wineImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Imaginea vinului
          Image.asset(
            wineImage,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          // Numele vinului
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              wineName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// Card detaliat pentru lista de vinuri din JSON
class WineDetailCard extends StatelessWidget {
  final Map<String, dynamic> wine;
  final bool isFavorite;
  final VoidCallback onFavoriteToggled;

  WineDetailCard({required this.wine, required this.isFavorite, required this.onFavoriteToggled});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Imaginea vinului
          Image.asset(
            wine['image'] ?? '',  // Verificăm dacă există cheia 'image'
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          // Detalii vin
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wine['name'] ?? 'Unknown',  // Verificăm dacă există cheia 'name'
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('${wine['type']} | ${wine['from']['country'] ?? 'Unknown'}'),  // Accesăm corect sub-cheile
                SizedBox(height: 8),
                Text('Price: ${wine['price_usd'] ?? 'N/A'} USD'),  // Folosim 'price_usd' din JSON
                SizedBox(height: 8),
                Text('Critic\'s Score: ${wine['critic_score'] ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Bottle: ${wine['bottle_size'] ?? 'N/A'}'),
              ],
            ),
          ),
          // Buton favorite
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: onFavoriteToggled,
          ),
        ],
      ),
    );
  }
}
