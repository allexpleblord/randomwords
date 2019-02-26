import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random word generator',
      home: RandomWords()
    );
  }
}

// Random words
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

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

  void _pushSaved() {
    Navigator.push( context,
      MaterialPageRoute(
        builder: (BuildContext context) => Favourites(_saved)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random word generator'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.menu), onPressed: _pushSaved)
        ],
      ),
      body:_buildSuggestions()
    );
  }
}

// Favourites page
class Favourites extends StatelessWidget {
  final Set<WordPair> favourites;

  Favourites(this.favourites);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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