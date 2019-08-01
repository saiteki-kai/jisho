import 'package:flutter/material.dart';

import 'package:jisho/data/repository.dart';
import 'package:jisho/widgets/word/word_list.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final repository = Repository.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Favorites', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: repository.getFavorites(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null)
                  return Center(child: Text("Loading..."));
                return WordList(snapshot.data);
              },
            ),
          )
        ],
      ),
    );
  }
}
