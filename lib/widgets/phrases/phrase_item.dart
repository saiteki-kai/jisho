import 'package:flutter/material.dart';

import 'package:jisho/models/sentence.dart';
import 'package:jisho/utils/japanese.dart';

class PhraseItem extends StatelessWidget {
  final Sentence sentence;
  final String query;

  PhraseItem(this.sentence, this.query);

  List<TextSpan> highlight(String sentence, String pattern) {
    var list = new List<TextSpan>();

    var p = RegExp("($pattern)", caseSensitive: false);

    var marked = sentence.replaceAllMapped(p, (m) => "§${m.group(0)}#");
    marked += "§";

    var tmp = "";
    marked.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);

      switch (character) {
        case "§":
          list.add(TextSpan(text: tmp));
          tmp = "";
          break;
        case "#":
          list.add(
            TextSpan(
              text: tmp,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
          tmp = "";
          break;
        default:
          tmp += character;
          break;
      }
    });

    return list;
  }

  get isJapanese => Japanese.hasKanji(query) || Japanese.hasKana(query);

  Widget buildText(text, cond, {TextStyle style}) {
    if (cond) {
      return RichText(
        text: TextSpan(
          style: style,
          children: highlight(text, query),
        ),
      );
    } else {
      return Text(text, style: style);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(DefaultTextStyle.of(context).style);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildText(sentence.jap, isJapanese,
            style: TextStyle(
              color: Color(0xdd000000),
              fontSize: 18,
              fontFamily: "DroidJP",
            )),
        buildText(sentence.eng, !isJapanese,
            style: TextStyle(
              color: Colors.grey[800],
            ))
      ],
    );
  }
}
