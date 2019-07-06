import 'package:flutter/material.dart';

import 'package:jisho/model/word.dart';
import 'package:jisho/widgets/word_item.dart';
import 'package:jisho/pages/details_page.dart';
import 'package:jisho/utils/slide.dart';

class WordList extends StatelessWidget {
  final List<Word> words;

  WordList(this.words);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(height: 1.0),
                itemCount: words.length,
                itemBuilder: (context, i) {
                  return new FlatButton(
                    padding: new EdgeInsets.all(16.0),
                    child: new WordItem(words[i]),
                    onPressed: () {
                      var route = new Slide(
                          builder: (context) => new DetailPage(words[i]));
                      Navigator.push(context, route);
                    },
                  );
                })));
  }
}
