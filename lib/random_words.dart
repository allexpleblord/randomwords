import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './favourites.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  // This builds all the random word suggestions
  Widget _buildSuggestions() {
    return ListView.builder(
      padding:EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        // Returning a Divider on every odd i ( on every second i )
        if (i.isOdd) return Divider();
        // Actual number of elements ( dividing because of the dividers )
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.add(WordPair.random());
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  // This builds each individual row
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else { 
            _saved.add(pair); 
          } 
        });
      },
    );
  }

  // This is fired when the appbar button is pressed
  // Goes to the favourites page
  void _pushFavourites() {
    Navigator.push( context,
      MaterialPageRoute(
        builder: (BuildContext context) => Favourites(_saved)
      ),
    );
  }

  // This is the build for the random words widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random word generator'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.menu), onPressed: _pushFavourites)
        ],
      ),
      body:_buildSuggestions()
    );
  }
}