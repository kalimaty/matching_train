import 'package:matching_train/src/models/model.dart';

Level level1 = Level(
  id: 1,
  levelName: "Level 1",
  sentences: [
    Sentence(
      words: [
        Word("I'm", 1),
        Word("Adham", 2),
      ],
      audio: "audios/level_001_1- I’m Adham..ogg",
    ),
    Sentence(
      words: [
        Word("I", 1),
        Word("like", 2),
        Word("Egypt", 3),
      ],
      audio: "audios/level_001_2- l like Egypt..ogg",
    ),
    Sentence(
      words: [
        Word("I", 1),
        Word("speak", 2),
        Word("Arabic", 3),
      ],
      audio: "audios/level_001_3- I speak Arabic..ogg",
    ),
  ],
);
Level level2 = Level(
  id: 2,
  levelName: "Level 2",
  sentences: [
    Sentence(
      words: [
        Word("Adham", 1),
        Word("is", 2),
        Word("tall", 3),
        Word(".", 4),
        Word("He", 5),
        Word("isn't", 6),
        Word("short", 7),
        Word(".", 8)
      ],
      audio: "audios/level_002_1- Adham is tall. He isn’t short..ogg",
    ),
    Sentence(
      words: [
        Word("The", 1),
        Word("elephant", 2),
        Word("is", 3),
        Word("big", 4),
        Word(".", 5),
        Word("It", 6),
        Word("isn't", 7),
        Word("small", 8),
        Word(".", 9)
      ],
      audio: "audios/level_002_2- The elephant is big. It isn’t small..ogg",
    ),
    Sentence(
      words: [
        Word("I", 1),
        Word("can", 2),
        Word("ride", 3),
        Word("bike", 4),
        Word("and", 5),
        Word("drive", 6),
        Word("a", 7),
        Word("car", 8),
        Word(".", 9),
      ],
      audio: "audios/level_002_3- I can ride a bike and drive a car..ogg",
    ),
  ],
);
Level level3 = Level(
  id: 3,
  levelName: "Level 3",
  sentences: [
    Sentence(
      //
      words: [],
      audio: "assets/audios/level_003_1- She’s eating an egg..ogg",
    ),
    Sentence(
      words: [],
      audio: "assets/audios/level_003_1- She’s eating an egg..ogg",
    ),
    Sentence(
      words: [],
      audio: "assets/audios/level_003_3-Our school start at 8.ogg",
    ),
  ],
);
Level level4 = Level(
  id: 4,
  levelName: "Level 4",
  sentences: [
    Sentence(
      words: [],
      audio:
          "assets/audios/level_004_1- I’m listening to pop music. It’s very good..ogg",
    ),
    Sentence(
      words: [],
      audio:
          "assets/audios/level_004_2- He’s drawing a cat. He loves cats..ogg",
    ),
    Sentence(
      words: [],
      audio:
          "assets/audios/level_004_3- l like drawing, but I don’t like listening to music..ogg",
    ),
  ],
);
Level level5 = Level(
  id: 5,
  levelName: "Level 5",
  sentences: [
    Sentence(
      words: [],
      audio: "assets/audios/level_005_1_what music are you listening to.ogg",
    ),
    Sentence(
      words: [],
      audio: "assets/audios/level_005_2_do you like playing sports.ogg",
    ),
    Sentence(
      words: [],
      audio: "assets/audios/level_005_3_what are you drawing at here.ogg",
    ),
  ],
);
final trainGameData = [
  level1,
  level2,

   
];
