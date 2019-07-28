import 'package:flutter/material.dart';

import 'package:jisho/models/word.dart';
import 'package:jisho/utils/dictionary.dart';

class WordItem extends StatelessWidget {
  final Word word;

  WordItem(this.word);

  String get title {
    if (word.writings.length > 0 && word.writings[0].kanji != null) {
      var text = word.writings[0].kanji.text;
      var reading = word.writings[0].kana.text;
      return text == null ? reading : "$text【$reading】";
    } else {
      return word.writings[0].kana.text;
    }
  }

  List<Pair> get others {
    if (word.writings.length > 0) {
      return word.writings.sublist(1);
    }

    return [];
  }

  bool get isCommon {
    if (word.writings.length > 0 && word.writings[0].kanji != null) {
      return word.writings[0].kanji.common ?? false;
    } else {
      return word.writings[0].kana.common ?? false;
    }
  }

  Container wordWidget(Word word) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isCommon)
            Text(
              "common",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
        ],
      ),
    );
  }

  Container othersWidget(otherForms) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Other forms",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: otherForms,
          ),
        ],
      ),
    );
  }

  Container dbpediaWidget(Word word) => Container(
        child: Text(
          "dbpedia",
        ),
      );

  Container sensesWidget(Word word) {
    var glossesWidget = <Widget>[];
    var oldPart = "";

    for (var s in word.senses) {
      var glosses = s.gloss.join(", ");

      var partsOfSpeech = s.partOfSpeech.map((x) {
        var tag = Dictionary.tags[x];
        return "${tag[0].toUpperCase()}${tag.substring(1)}";
      }).join(", ");

      glossesWidget.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (partsOfSpeech != oldPart) // groups partsOfSpeech
              Container(
                child: Text(
                  partsOfSpeech,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            Container(
              child: Text(
                "${word.senses.indexOf(s) + 1}. $glosses",
              ),
            ),
          ],
        ),
      );

      oldPart = partsOfSpeech;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: glossesWidget,
      ),
    );
  }

  List<Widget> buildChildren(Word word) {
    var otherForms = others
        .map((o) => o.kanji.text == null
            ? o.kana.text
            : "${o.kanji.text}【${o.kana.text}】")
        .toList()
        .map((t) => Text(t, style: TextStyle(fontWeight: FontWeight.w400)))
        .toList();

    return [
      wordWidget(word),
      sensesWidget(word),
      //if (false) dbpediaWidget(word),
      if (others.length > 0)
        othersWidget(otherForms),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buildChildren(word),
      ),
    );
  }
}
