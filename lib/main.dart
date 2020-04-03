// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: RandomWords(),

    );
  }
}
class RandomWordsState extends State<RandomWords> {
 final _suggestions = <WordPair>[];
 final _biggerFont = const TextStyle(fontSize: 18.0);
 final _saved = Set<WordPair>();
 Widget _buildSuggestions(){
   return ListView.builder(
     padding: const EdgeInsets.all(16.0),
     itemBuilder: (context, i){
       if (i.isOdd) return Divider();

       final index = i ~/ 2 ;
       if (index >= _suggestions.length) {
         _suggestions.addAll(prefix0.generateWordPairs().take(10));
       }
      return _buildRow(_suggestions[index]);
     }
   );
 }
 Widget _buildRow(WordPair pair){
   final bool alreadySaved = _saved.contains(pair);
   return ListTile(
     title: Text(
       pair.asPascalCase,
       style: _biggerFont,
     ),
     trailing: Icon(
       alreadySaved ? Icons.favorite : Icons.favorite_border,
       color: alreadySaved ? Colors.red : null,
     ),
     onTap: (){
         setState(() {
           if (alreadySaved) _saved.remove(pair);
           else _saved.add(pair);
         });
     }, //onTap
   );
}

  void _pushSaved(){
   Navigator.of(context).push(
     MaterialPageRoute<void>(
         builder: (BuildContext context) {
           final Iterable<ListTile> tiles = _saved.map(
                 (WordPair pair) {
               return ListTile(
                 leading: Icon(Icons.list),
                 title: Text(
                   pair.asPascalCase,
                   style: _biggerFont,
                 ),
                 trailing: Icon(
                   Icons.favorite,
                   color: Colors.red,
                 ),
                 onTap: (){
                   setState(() {
                     _saved.remove(pair);
                   });
                 },
               );
               },
           );
           final List<Widget> divided = ListTile
               .divideTiles(
             context: context,
             tiles: tiles,

           )
               .toList();
           return Scaffold(
             appBar: AppBar(
               title: Text('saved Suggestions'),
              // backgroundColor: Colors.red,
             ),
             body: ListView(children: divided),

           );
         },
     ),
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('startup name generator'),
        //backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),

      body: _buildSuggestions(),

    );
  }
  } //randomWordState

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}