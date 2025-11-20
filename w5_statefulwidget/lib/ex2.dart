import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Favorite cards"),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: const [
            FavoriteCard(
              title: "title",
              description: "description",
              initialFavorite: true,
            ),
            FavoriteCard(
              title: "title",
              description: "description",
              initialFavorite: false,
            ),
            FavoriteCard(
              title: "title",
              description: "description",
              initialFavorite: true,
            ),
          ],
        ),
      ),
    ),
  );
}

class FavoriteCard extends StatefulWidget {
  final String title;
  final String description;
  final bool initialFavorite;
  const FavoriteCard({
    required this.title,
    required this.description,
    required this.initialFavorite,
    super.key,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(widget.description),
            trailing: GestureDetector(
              onTap: toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 28,
              ),
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
