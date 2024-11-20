import 'package:flutter/material.dart';

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

  // Datele vinurilor care vor fi afișate mai jos de categorie
  final List<Map<String, String>> wineList = [
    {
      'name': 'Château Margaux',
      'type': 'Red Wine',
      'country': 'France',
      'price': '\$350',
      'score': '4.8',
      'bottle': '700ml',
      'image': 'assets/redwine.png',
    },
    {
      'name': 'Purcari 1827',
      'type': 'White Wine',
      'country': 'Moldova',
      'price': '\$50',
      'score': '4.5',
      'bottle': '700ml',
      'image': 'assets/redwine.png',
    },
    {
      'name': 'Alira Rosé',
      'type': 'Rosé Wine',
      'country': 'Romania',
      'price': '\$30',
      'score': '4.2',
      'bottle': '700ml',
      'image': 'assets/redwine.png',
    },
    {
      'name': 'Champagne Moët',
      'type': 'Sparkling Wine',
      'country': 'France',
      'price': '\$150',
      'score': '4.7',
      'bottle': '700ml',
      'image': 'assets/redwine.png',
    },
    {
      'name': 'Negru de Purcari',
      'type': 'Red Wine',
      'country': 'Moldova',
      'price': '\$80',
      'score': '4.6',
      'bottle': '700ml',
      'image': 'assets/redwine.png',
    },
  ];

  // Pentru a controla dacă un vin este adăugat la favorite
  final Map<int, bool> favoriteStatus = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('V2', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_outlined, color: Colors.black),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location and search bar section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      'Donnerville Drive',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.search, color: Colors.black),
                    SizedBox(width: 8),
                    Icon(Icons.mic, color: Colors.black),
                  ],
                )
              ],
            ),
          ),
          // "Shop wines by" title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Shop wines by',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
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
                  // Lista de 5 vinuri de mai jos
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
                  })
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

// Card detaliat pentru lista de vinuri de jos
class WineDetailCard extends StatelessWidget {
  final Map<String, String> wine;
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
            wine['image']!,
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
                  wine['name']!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('${wine['type']} | ${wine['country']}'),
                SizedBox(height: 8),
                Text('Price: ${wine['price']}'),
                SizedBox(height: 8),
                Text('Critic\'s Score: ${wine['score']}'),
                Text('Bottle: ${wine['bottle']}'),
              ],
            ),
          ),
          // Iconiță Favorite
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
