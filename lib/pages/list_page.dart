import 'package:flutter/material.dart';

import 'package:jisho/model/word.dart';
import 'package:jisho/data/repository.dart';
import 'package:jisho/widgets/word_list.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  var _input;

  Future<List<Word>> _fetchData(query) async {
    print("fetch: $query");

    if (query == null || query == "") return null;

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
          ))); // aggiungere ricerca per radicali

  updateSearch(value) {
    setState(() {
      _input = value;
    });
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

class SearchBar extends StatelessWidget {
  final Function update;
  SearchBar(this.update);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.red[400], boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SearchField(update),
            ),
          ),
        ));
  }
}

class SearchField extends StatelessWidget {
  final Function update;
  SearchField(this.update);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          hintText: "Search for Kanji, Words and Terms...",
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Colors.black.withOpacity(0.5),
          )),
      onSubmitted: (value) => update(value),
    );
  }
}
