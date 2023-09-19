class Level {
  List<Sentence> sentences;
  String levelName;
  int id;
  Level({required this.id, required this.sentences, required this.levelName});
}

class Sentence {
  final List<Word> words;
  final String audio;
  Sentence({required this.words, required this.audio});
}

class Word {
  final String word;
  final int serialNo;

  Word(this.word, this.serialNo);
}
