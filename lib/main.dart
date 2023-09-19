import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';
import 'src/models/hive_object/level_unlock.dart';
import 'src/screens/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LevelUnlockAdapter());
  var levelBox = await Hive.openBox<LevelUnlock>(LEVEL_BOXS);
  LevelUnlock? userLevel = levelBox.get(userLevelName);

  if (userLevel == null) {
    userLevel = LevelUnlock(level: 1);
    levelBox.put(userLevelName, userLevel);
  }
  levelBox.close();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Train Matching',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
