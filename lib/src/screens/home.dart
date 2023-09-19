import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:matching_train/src/components/basic/level_item.dart';
import 'package:matching_train/constants.dart';
import 'package:matching_train/functions.dart';
import 'package:matching_train/src/data/local/data.dart';

import '../models/model.dart';
import '../models/hive_object/level_unlock.dart';
import 'end_screen.dart';
import 'level_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late Box box;
  late LevelUnlock userLevel;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    box.close();
    // Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Select Levels"),
          ),
          FutureBuilder<Box>(
              future: Hive.openBox(LEVEL_BOXS),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                box = snapshot.data!;
                userLevel = box.get(userLevelName);

                return Container(
                  child: Column(children: [
                    ...trainGameData
                        .map((e) => LevelItem(
                              e.id,
                              unlocked: userLevel.level >= e.id,
                              onPressed: () {
                                launch(
                                  context,
                                  LevelPage(
                                    level: e,
                                    home: this,
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ]),
                );
              }),
          Container()
        ],
      ),
    );
  }

  nextLevel(Level currentLevel) async {
    int currentIndex =
        trainGameData.indexWhere((element) => currentLevel == element);
    int nextIndex = currentIndex + 1;
    userLevel = LevelUnlock(level: nextIndex + 1);
    box.put(userLevelName, userLevel);
    if (trainGameData.length == nextIndex) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EndScreen(),
        ),
      );
    } else {
      launch(
        context,
        LevelPage(
          level: trainGameData[nextIndex],
          home: this,
        ),
      );
    }
  }
}
