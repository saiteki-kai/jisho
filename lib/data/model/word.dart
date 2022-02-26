import 'package:objectbox/objectbox.dart';

@Entity()
class WordEntry {
  @Id(assignable: true)
  final int id;

  final kanji = ToMany<Kanji>();
  final reading = ToMany<Reading>();
  final sense = ToMany<Sense>();

  WordEntry({required this.id});

  @override
  String toString() => 'WordEntry(id: $id)';
}

@Entity()
class Kanji {
  int id = 0;

  @Index()
  String? text;
  List<String>? info;
  bool common;

  Kanji({this.text, this.info, this.common = false});

  @override
  String toString() {
    return 'Kanji(id: $id, text: $text, info: $info, common: $common)';
  }
}

@Entity()
class Reading {
  int id = 0;

  @Index()
  String? text;
  List<String>? info;
  List<String>? restrictedTo;
  bool common;

  Reading({this.text, this.info, this.restrictedTo, this.common = false});

  @override
  String toString() {
    return 'Reading(id: $id, text: $text, info: $info, restrictedTo: $restrictedTo, common: $common)';
  }
}

@Entity()
class Sense {
  int id = 0;

  String? pos;
  List<String>? related;
  List<String>? antonym;
  List<String>? field;
  List<String>? dialect;
  List<String>? misc;
  List<String>? info;
  List<String>? stagk; // applies to a kanji
  List<String>? stagr; // applies to a reading

  @Index()
  final gloss = ToMany<Gloss>();

  Sense({
    this.pos,
    this.related,
    this.antonym,
    this.field,
    this.dialect,
    this.misc,
    this.info,
    this.stagk,
    this.stagr,
  });

  @override
  String toString() {
    return 'Sense(id: $id, pos: $pos, related: $related, antonym: $antonym, field: $field, dialect: $dialect, misc: $misc, info: $info, stagk: $stagk, stagr: $stagr, gloss: $gloss)';
  }
}

@Entity()
class Gloss {
  int id = 0;
  @Index()
  String? text;
  String? type;

  Gloss({this.text, this.type});

  @override
  String toString() => 'Gloss(id: $id, text: $text, type: $type)';
}
