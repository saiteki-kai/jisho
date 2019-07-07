import 'package:flutter/material.dart';

import 'package:jisho/models/word.dart';
import 'package:jisho/widgets/word_item.dart';
import 'package:jisho/pages/details_page.dart';
import 'package:jisho/data/repository.dart';
import 'package:jisho/utils/slide.dart';

class WordList extends StatelessWidget {
  final List<Word> words;

  WordList(this.words);

  @override
  Widget build(BuildContext context) {
    var count = words == null ? 0 : words.length;

    return Container(
        child: Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(height: 1.0),
                itemCount: count + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Words - $count found"),
                    );
                  }

                  index--; // decrease the current each time

                  return new FlatButton(
                    padding: new EdgeInsets.all(16.0),
                    child: new WordItem(words[index]),
                    onPressed: () {
                      Repository.get().setVisitedWord(words[index].id);
                      var route = new Slide(
                          builder: (context) => new DetailPage(words[index]));
                      Navigator.push(context, route);
                    },
                  );
                })));
  }
}
