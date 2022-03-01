class WordEntry {
  int id;
  List<Kanji> kanji;
  List<Reading> reading;
  List<Sense> sense = [];

  WordEntry({required this.id, required this.kanji, required this.reading});

  @override
  String toString() =>
      'WordEntry(id: $id, kanji: ${kanji.map((k) => k.toString())}, reading: ${reading.map((r) => r.toString())}, sense: ${sense.map((r) => r.toString())})';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kanji': kanji.map((x) => x.toMap()).toList(),
      'reading': reading.map((x) => x.toMap()).toList(),
      // 'sense': sense.map((x) => x.toMap()).toList(),
    };
  }

  factory WordEntry.fromMap(Map<String, dynamic> map) {
    return WordEntry(
      id: map['id']?.toInt() ?? 0,
      kanji: List<Kanji>.from(map['kanji']?.map((x) => Kanji.fromMap(x))),
      reading:
          List<Reading>.from(map['reading']?.map((x) => Reading.fromMap(x))),
      //sense: List<Sense>.from(map['sense']?.map((x) => Sense.fromMap(x))),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WordEntry && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class Kanji {
  int id;
  String text;
  List<String> info;
  bool common;

  Kanji({
    required this.id,
    required this.text,
    required this.info,
    required this.common,
  });

  @override
  String toString() {
    return 'Kanji(id: $id, text: $text, info: $info, common: $common)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'info': info,
      'common': common,
    };
  }

  factory Kanji.fromMap(Map<String, dynamic> map) {
    return Kanji(
      id: map['id']?.toInt() ?? 0,
      text: map['text'] ?? '',
      info: List<String>.from(map['info'] ?? []),
      common: map['common'] == 1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Kanji && other.id == id && other.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode;
  }
}

class Reading {
  int id;
  String text;
  List<String> info;
  List<String> restrictedTo;
  bool common;

  Reading({
    required this.id,
    required this.text,
    required this.info,
    required this.restrictedTo,
    required this.common,
  });

  @override
  String toString() {
    return 'Reading(id: $id, text: $text, info: $info, restrictedTo: $restrictedTo, common: $common)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'info': info,
      'restrictedTo': restrictedTo,
      'common': common,
    };
  }

  factory Reading.fromMap(Map<String, dynamic> map) {
    return Reading(
      id: map['id']?.toInt() ?? 0,
      text: map['text'] ?? '',
      info: List<String>.from(map['info'] ?? []),
      restrictedTo: List<String>.from(map['restrictedTo'] ?? []),
      common: map['common'] == 1,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reading && other.id == id && other.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode;
  }
}

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

  final gloss = <Gloss>[];

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sense && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}

class Gloss {
  int id;
  String text;
  String type;

  Gloss({
    required this.id,
    required this.text,
    required this.type,
  });

  @override
  String toString() => 'Gloss(id: $id, text: $text, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Gloss && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
