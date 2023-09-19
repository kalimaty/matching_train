import 'package:hive/hive.dart';
part 'level_unlock.g.dart';

const LEVEL_BOXS = 'MatchingTrainBox';

@HiveType(typeId: 0)
class LevelUnlock {
  @HiveField(0)
  int level;
  LevelUnlock({
    required this.level,
  });
}
