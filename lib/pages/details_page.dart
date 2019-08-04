import 'package:flutter/material.dart';

import 'package:jisho/data/history_dao.dart';
import 'package:jisho/models/word.dart';
import 'package:jisho/widgets/word/word_item.dart';
import 'package:jisho/widgets/kanji/kanji_tab.dart';
import 'package:jisho/widgets/phrases/phrases_tab.dart';

class DetailPage extends StatefulWidget {
  final Word word;

  DetailPage(this.word);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _isFavorite = false;

  @override
  initState() {
    super.initState();
    HistoryDao().isFavorited(widget.word).then((value) {
      setState(() {
        _isFavorite = value;
      });
    });
  }

  Container wordWidget(Word word) => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              WordItem(word),
              Text("DBPedia"),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _title = "";
    if (widget.word.writings.length > 0) {
      if (widget.word.writings[0].kanji != null) {
        _title = widget.word.writings[0].kanji.text;
      } else {
        _title = widget.word.writings[0].kana.text;
      }
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title, style: TextStyle(fontFamily: "DroidJP")),
          backgroundColor: Colors.red[400],
          bottom: TabBar(
            tabs: [
              Tab(text: "WORD"),
              Tab(text: "KANJI"),
              Tab(text: "PHRASES"),
            ],
            indicatorColor: Colors.white,
          ),
          actions: <Widget>[
            IconButton(
              icon: _isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                HistoryDao().setFavorite(widget.word, !_isFavorite).then((val) {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                });
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            wordWidget(widget.word),
            KanjiTab(widget.word),
            PhrasesTab(_title),
          ],
        ),
      ),
    );
  }
}
