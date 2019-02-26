import 'package:flutter/material.dart';
import './random_words.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random word generator',
      theme: ThemeData(
        primaryColor: Colors.pink
      ),
      home: RandomWords()
    );
  }
}