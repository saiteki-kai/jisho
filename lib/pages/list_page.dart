import 'package:flutter/material.dart';

import 'package:jisho/model/word.dart';
import 'package:jisho/data/repository.dart';
import 'package:jisho/widgets/search_bar.dart';
import 'package:jisho/widgets/word_list.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  MapEntry<String, List<Word>> _old;
  String _input;

  Future<List<Word>> _fetchData(query) async {
    if (query == null || query == "") return null;

    if (query == _old.key) return _old.value;

    return await Repository.get().findWords(query);
  }

  Container message() => new Container(
      child: Expanded(
          flex: 1,
          child: Center(
            child: Text("辞書",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize: 120.0)),
          )));

  updateSearch(value) {
    setState(() {
      _input = value;
    });
  }

  @override
  void initState() {
    print("init");
    _old = Repository.get().getLastSearch();
    updateSearch(_old.key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SearchBar(updateSearch),
          FutureBuilder(
              future: _fetchData(_input),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return message();
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Expanded(
                        flex: 1,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.amber),
                          ),
                        ));
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text(
                        'Error:\n\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      );
                    else if (snapshot.data == null)
                      return message();
                    else
                      return WordList(snapshot.data);
                }
              })
        ],
      ),
    );
  }
}
