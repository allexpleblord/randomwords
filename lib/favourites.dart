import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Favourites extends StatelessWidget {
  final Set<WordPair> favourites;

  // Constructor to get the set of wordpairs
  Favourites(this.favourites);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Your favorites')
      ),
      body: 
      Column(children: favourites.map((favourite) =>
        Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              favourite.asPascalCase,
              style: TextStyle(fontSize: 18.0)
            )
          )
        )
      ).toList())
    );
  }
}