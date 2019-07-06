import 'package:flutter/material.dart';

import 'package:jisho/model/word.dart';
import 'package:jisho/utils/dictionary.dart';

class WordItem extends StatelessWidget {
  final word;

  WordItem(this.word);

  Container wordWidget(Word word) => Container(
        child: new Text(
          word.kanji[0].text,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      );

  Container othersWidget(otherForms) {
    return Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text("Other forms", style: TextStyle(fontWeight: FontWeight.w400)),
      Row(children: otherForms)
    ]));
  }

  Container dbpediaWidget(Word word) => Container(
        child: new Text("dbpedia"),
      );

  Container sensesWidget(Word word) {
    var glossesWidget = <Widget>[];
    var oldPart = "";

    for (var s in word.sense) {
      var glosses = s.gloss.map((x) => x.text).join(", ");

      var partsOfSpeech = s.partOfSpeech.map((x) {
        var tag = Dictionary.tags[x];
        return "${tag[0].toUpperCase()}${tag.substring(1)}";
      }).join(", ");

      glossesWidget.add(
        new Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (partsOfSpeech != oldPart) // groups partsOfSpeech
            Container(
                child: Text(partsOfSpeech,
                    style: TextStyle(fontWeight: FontWeight.w400))),
          Container(child: Text("${word.sense.indexOf(s) + 1}. $glosses"))
        ]),
      );

      oldPart = partsOfSpeech;
    }

    return new Container(
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: glossesWidget),
    );
  }

  List<Widget> buildChildren(Word word) {
    var otherForms = <Widget>[];
    for (var k in word.kanji.sublist(1)) {
      otherForms.add(
          new Text(k.text, style: TextStyle(fontWeight: FontWeight.w600)));
    }

    return [
      wordWidget(word),
      sensesWidget(word),
      //if (false) dbpediaWidget(word),
      if (otherForms.length > 0)
        othersWidget(otherForms)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buildChildren(word),
      ),
    );
  }
}
