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

  Kanji({String? text, List<String>? info, this.common = false}) {
    this.text = (text?.isNotEmpty ?? false) ? text : null;
    this.info = (info?.isNotEmpty ?? false) ? info : null;
  }

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

  Reading({
    String? text,
    List<String>? info,
    List<String>? restrictedTo,
    this.common = false,
  }) {
    this.text = (text?.isNotEmpty ?? false) ? text : null;
    this.info = (info?.isNotEmpty ?? false) ? info : null;
    this.restrictedTo =
        (restrictedTo?.isNotEmpty ?? false) ? restrictedTo : null;
  }

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

  final gloss = ToMany<Gloss>();

  Sense({
    String? pos,
    List<String>? related,
    List<String>? antonym,
    List<String>? field,
    List<String>? dialect,
    List<String>? misc,
    List<String>? info,
    List<String>? stagk,
    List<String>? stagr,
  }) {
    this.pos = (pos?.isNotEmpty ?? false) ? pos : null;
    this.related = (related?.isNotEmpty ?? false) ? related : null;
    this.antonym = (antonym?.isNotEmpty ?? false) ? antonym : null;
    this.field = (field?.isNotEmpty ?? false) ? field : null;
    this.dialect = (dialect?.isNotEmpty ?? false) ? dialect : null;
    this.misc = (misc?.isNotEmpty ?? false) ? misc : null;
    this.info = (info?.isNotEmpty ?? false) ? info : null;
    this.stagk = (stagk?.isNotEmpty ?? false) ? stagk : null;
    this.stagr = (stagr?.isNotEmpty ?? false) ? stagr : null;
  }

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

  Gloss({String? text, String? type}) {
    this.text = (text?.isNotEmpty ?? false) ? text : null;
    this.type = (type?.isNotEmpty ?? false) ? type : null;
  }

  @override
  String toString() => 'Gloss(id: $id, text: $text, type: $type)';
}
