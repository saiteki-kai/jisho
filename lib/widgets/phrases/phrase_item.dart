import 'package:flutter/material.dart';

import 'package:jisho/models/sentence.dart';

class PhraseItem extends StatelessWidget {
  final Sentence sentence;
  final String query;
  PhraseItem(this.sentence, this.query);

  List<TextSpan> highlight(String sentence, String pattern) {
    var list = new List<TextSpan>();

    var marked = sentence.replaceAllMapped(pattern, (m) => "§${m.pattern}#");
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
          list.add(TextSpan(
              text: pattern,
              style:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)));
          tmp = "";
          break;
        default:
          tmp += character;
          break;
      }
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: highlight(sentence.jpn, query),
          ),
        ),
        Text(sentence.eng),
      ],
    );
  }
}
