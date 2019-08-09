class Sentence {
  String jap;
  String eng;

  Sentence({
    this.jap,
    this.eng,
  });

  factory Sentence.fromMap(Map<String, dynamic> map) => Sentence(
        jap: map["jap"],
        eng: map["eng"],
      );

  Map<String, dynamic> toMap() => {
        "jap": jap,
        "eng": eng,
      };
}
