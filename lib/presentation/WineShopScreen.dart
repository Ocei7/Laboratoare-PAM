import 'package:flutter/material.dart';
import 'package:lab1/data/WineData.dart';
import 'package:lab1/domain/Wine.dart';

class WineShopScreen extends StatefulWidget {
  @override
  _WineShopScreenState createState() => _WineShopScreenState();
}

class _WineShopScreenState extends State<WineShopScreen> {
  String selectedCategory = 'Type';
  List<Map<String, dynamic>> wineList = [];
  final Map<int, bool> favoriteStatus = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await WineData.loadWineData();
    setState(() {
      wineList = data;
    });
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
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Shop wines by',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: WineData.wineCategories.keys.map((category) {
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: WineData.wineCategories[selectedCategory]!
                            .map((wine) => WineCard(
                          wineName: wine['name']!,
                          wineImage: wine['image']!,
                        ))
                            .toList(),
                      ),
                    ),
                  ),
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
