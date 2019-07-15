class Sentence {
  String jpn;
  String eng;

  Sentence({
    this.jpn,
    this.eng,
  });

  factory Sentence.fromMap(Map<String, dynamic> map) => new Sentence(
    jpn: map["jpn"],
    eng: map["eng"],
  );

  Map<String, dynamic> toMap() => {
    "jpn": jpn,
    "eng": eng,
  };
}