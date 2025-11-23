import 'package:flutter/material.dart';
import 'jokes.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: const JokesList()
    ),
  ),
);

class JokesList extends StatefulWidget {
  const JokesList({super.key});

  @override
  State<JokesList> createState() => _JokesListState();
}


class _JokesListState extends State<JokesList> {
  // only 1 fav at a time
  int? _favoriteIndex;

  void setFavorite(int index) {
    setState(() {
      _favoriteIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokesList.length,
      itemBuilder: (context, index) {
        return FavoriteCard(
          joke: jokesList[index],
          isFavorite: _favoriteIndex == index,
          index: index,
          onFavoriteClick: setFavorite,
        );
      },
    );
  }
}

class FavoriteCard extends StatelessWidget  {
  final Joke joke;
  final bool isFavorite;
  final int index;
  final Function(int) onFavoriteClick;
  
  const FavoriteCard({
    required this.joke,
    required this.isFavorite,
    required this.index,
    required this.onFavoriteClick,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: .5, color: Colors.grey)),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.title,
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(joke.description),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onFavoriteClick(index),
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
