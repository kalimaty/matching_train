import 'package:flutter/material.dart';

import 'package:matching_train/src/models/model.dart';

import 'train_screen_composed.dart';
import 'home.dart';
import 'package:flutter/services.dart';

class LevelPage extends StatefulWidget {
  final Level level;
  final HomeState home;
  const LevelPage({super.key, required this.level, required this.home});

  @override
  State<LevelPage> createState() => LevelPageState();
}

class LevelPageState extends State<LevelPage> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    pageController = PageController(initialPage: 0);
  }

  nextPage() async {
    if (pageController.page!.toInt() == (widget.level.sentences.length - 1)) {
      await widget.home.nextLevel(widget.level);
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: widget.level.sentences.length,
        itemBuilder: (context, index) {
          return TrainScreenComposed(
            levelPageState: this,
            sentence: widget.level.sentences[index],
          );
        });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
    pageController.dispose();
  }
}
