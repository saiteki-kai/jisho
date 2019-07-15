import 'package:flutter/material.dart';

import 'package:jisho/models/word.dart';
import 'package:jisho/utils/dictionary.dart';

class WordItem extends StatelessWidget {
  final Word word;

  WordItem(this.word);

  String get title {
    if (word.kanji.length > 0) {
      var text = word.kanji[0].text;
      return "$text 【${associateReading(text)}】";
    } else {
      return word.kana[0].text;
    }
  }

  List<Kanji> get others {
    if (word.kanji.length > 0) {
      return word.kanji.sublist(1);
    }

    return [];
  }

  bool get isCommon {
    if (word.kanji.length > 0) {
      return word.kanji[0].common;
    } else {
      return word.kana[0].common;
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

    for (var s in word.sense) {
      var glosses = s.gloss.map((x) => x.text).join(", ");

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
                "${word.sense.indexOf(s) + 1}. $glosses",
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

  associateReading(String kanji) {
    for (var k in word.kana) {
      if (k.appliesToKanji.any((x) => x == kanji || x == "*")) {
        return k.text;
      }
    }

    return "";
  }

  // currently unused
  associateReadings(Word word) {
    var map = Map<String, String>();
    word.kanji.forEach((k) => map[k.text] = associateReading(k.text));

    return map;
  }

  List<Widget> buildChildren(Word word) {
    var otherForms = others
        .map((o) => "${o.text} 【${associateReading(o.text)}】")
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
