import 'package:flutter/material.dart';

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
          Image.asset(
            wineImage,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
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

class WineDetailCard extends StatelessWidget {
  final Map<String, dynamic> wine;
  final bool isFavorite;
  final VoidCallback onFavoriteToggled;

  WineDetailCard({
    required this.wine,
    required this.isFavorite,
    required this.onFavoriteToggled,
  });

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
          Image.asset(
            wine['image'] ?? '',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wine['name'] ?? 'Unknown',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('${wine['type']} | ${wine['from']['country'] ?? 'Unknown'}'),
                SizedBox(height: 8),
                Text('Price: ${wine['price_usd'] ?? 'N/A'} USD'),
                SizedBox(height: 8),
                Text('Critic\'s Score: ${wine['critic_score'] ?? 'N/A'}'),
                SizedBox(height: 8),
                Text('Bottle: ${wine['bottle_size'] ?? 'N/A'}'),
              ],
            ),
          ),
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
