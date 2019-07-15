import 'package:flutter/material.dart';

import 'package:jisho/models/sentence.dart';
import 'package:jisho/widgets/phrases/phrase_item.dart';

class PhrasesList extends StatelessWidget {
  final List<Sentence> phrases;
  final String query;

  PhrasesList(this.phrases, this.query);

  @override
  Widget build(BuildContext context) {
    var count = phrases == null ? 0 : phrases.length;

    return Container(
        child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(height: 1.0),
            itemCount: count,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: PhraseItem(phrases[index], query),
              );
            }),);
  }
}
