// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:matching_train/src/models/model.dart';
import 'package:matching_train/src/components/animations/floating_animation.dart';

import '../../../functions.dart';
import '../animations/arrange_start_animation.dart';
import '../animations/slide_animation.dart';
import '../../screens/level_page.dart';
import 'train_animations.dart';
import 'package:just_audio/just_audio.dart' as ja;

class FullTrain extends StatefulWidget {
  final Sentence sentence;
  final LevelPageState levelPageState;
  const FullTrain(
      {Key? key, required this.sentence, required this.levelPageState})
      : super(key: key);

  @override
  State<FullTrain> createState() => _FullTrainState();
}

class _FullTrainState extends State<FullTrain>
    with SingleTickerProviderStateMixin {
  late List<Word> unorderWords;
  List<String> selectedOrder = [];
  late List<String> correctOrder = [];

  late List<Widget> selectedTrainPart;
  late List<StatelessTrainPart> unSelectedTrainPart;
  late Alignment trainAlignment;
  bool isCompleteCorrectly = false;
  bool showCheck = false;

  late AnimationController controller;
  late Animation<Offset> animation;
  final player = ja.AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    trainAlignment = Alignment(0, 0.8);
    widget.sentence.words.forEach((element) {
      correctOrder.add(element.word);
    });
    unorderWords = widget.sentence.words;
    unorderWords.shuffle();
    selectedTrainPart = [];
    unSelectedTrainPart = unorderWords.map((e) {
      int i = e.serialNo;
      late StatelessTrainPart child;

      child = (i % 2 == 0)
          ? OrangeTrainPart(centerWord: unorderWords[i - 1].word)
          : BlueTrainPart(
              centerWord: unorderWords[i - 1].word,
            );
      return child;
    }).toList();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    animation =
        Tween(begin: Offset(0, 0), end: Offset(3, 0)).animate(controller);
    setSound();
    super.initState();
  }

  resetTrain() {
    // unorderWords = widget.sentence.words;
    showCheck=false;
      unorderWords = [...widget.sentence.words];
    unorderWords.shuffle();
    selectedTrainPart.clear();
    unSelectedTrainPart = unorderWords.map((e) {
      int i = e.serialNo;
      late StatelessTrainPart child;

      child = (i % 2 == 0)
          ? OrangeTrainPart(centerWord: unorderWords[i - 1].word)
          : BlueTrainPart(
              centerWord: unorderWords[i - 1].word,
            );
      return child;
    }).toList();
    selectedOrder.clear();
  }

  setSound() async {
    if (Platform.isLinux) {
      await audioPlayer.setSourceAsset(widget.sentence.audio);
    } else {
      player.setAsset("assets/" + widget.sentence.audio);
    }
  }

  @override
  void dispose() {
    selectedOrder.clear();
    audioPlayer.stop();
    audioPlayer.dispose();
    player.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(-.7, -.9),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                resetTrain();
                setState(() {});
              },
              child: Text(
                "Reset",
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: unSelectedTrainPart
                  .map((e) => ArrangeStartAnimation(child: e))
                  .toList(),
            ),
          ),
          AnimatedAlign(
            duration: Duration(seconds: 1),
            curve: Curves.easeInExpo,
            alignment: Alignment(0.5, 0.8),
            child: DragTarget<StatelessTrainPart>(
              onAcceptWithDetails: (details) {
                int numOfAns = selectedTrainPart.length;

                selectedTrainPart.add(TrainPartDropAnimation(
                  numOfAns: numOfAns,
                  offsetX: details.offset.dx,
                  child: details.data.trainPart(),
                ));
                selectedOrder.add(details.data.getCenterWord);
                unSelectedTrainPart
                    .removeWhere((element) => element == details.data);

                if (areListsEqual(correctOrder, selectedOrder)) {
                  widget.sentence.audio;
                  if (Platform.isLinux) {
                    audioPlayer.resume();
                  } else {
                    player.play();
                  }
                  print("Good Job");

                  showCheck = true;
                } else if (!areListsEqual(correctOrder, selectedOrder) &&
                    correctOrder.length <= selectedOrder.length) {
                  print("Miss match");
                  resetTrain();
                }
                setState(() {});
              },
              onWillAccept: (data) => true,
              builder: (context, candidateData, rejectedData) => SizedBox(
                width: double.infinity,
                height: 150,
                child: SlideTransition(
                  position: animation,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...selectedTrainPart,
                      if (isCompleteCorrectly)
                        SlideAnimation(
                          child: TrainFrontPart(),
                          offset: Offset(4, 0),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // الانتقال لمستوى التالى
          if (showCheck)
            Align(
              alignment: Alignment(-0.8, 0),
              child: FloatingAnimation(
                child: InkWell(
                  onTap: () {
                    isCompleteCorrectly = true;
                    showCheck = false;
                    Future.delayed(Duration(seconds: 2)).then((value) {
                         // الانتقال لمستوى التالى
                      controller.forward().then((value) async {
                        await widget.levelPageState.nextPage();
                      });
                    });
                    setState(() {});
                  },
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
              ),
            ),
          if (showCheck)
            Align(
              alignment: Alignment(0.8, 0),
              child: FloatingAnimation(
                child: InkWell(
                  onTap: () {
                    isCompleteCorrectly = true;
                    showCheck = false;
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      controller.forward().then((value) async {
                        await widget.levelPageState.nextPage();
                      });
                    });
                    setState(() {});
                  },
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TrainFrontPart extends StatelessWidget {
  const TrainFrontPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
          height: size.height / 5,
          width: size.height / 4.25,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment(0, 1),
                  child: Image.asset("assets/images/train_front_part.png")),
              Align(
                alignment: Alignment(-0.7, 1.2),
                child: BigTrainTair(),
              ),
              Align(
                alignment: Alignment(0, 1.2),
                child: BigTrainTair(),
              ),
              Align(
                alignment: Alignment(0.7, 1.2),
                child: TrainTair(),
              ),
            ],
          )),
    );
  }
}

class BlueTrainPart extends StatelessTrainPart {
  const BlueTrainPart({Key? key, required centerWord})
      : super(centerWord: centerWord, key: key);
  final String image = "assets/images/blue_train_part.png.png";
}

class OrangeTrainPart extends StatelessTrainPart {
  const OrangeTrainPart({Key? key, required centerWord})
      : super(centerWord: centerWord, key: key);
  final String image = "assets/images/orange_train_part.png";
}

class StatelessTrainPart extends StatelessWidget {
  const StatelessTrainPart({
    Key? key,
    required this.centerWord,
  }) : super(key: key);
  final String centerWord;
  String get getCenterWord => centerWord;
  final String image = "";
  @override
  Widget build(BuildContext context) {
    Widget child = TrainPart(
      image: image,
      centerWord: centerWord,
    );
    return Draggable(
      data: this,
      child: trainPart(),
      feedback: child,
      childWhenDragging: SizedBox(),
    );
  }

  Widget trainPart() {
    return TrainPart(
      image: image,
      centerWord: centerWord,
    );
  }
}

class TrainPart extends StatefulWidget {
  const TrainPart({
    Key? key,
    required this.image,
    required this.centerWord,
  }) : super(key: key);
  final String image;
  final String centerWord;
  @override
  State<TrainPart> createState() => _TrainPartState();
}

class _TrainPartState extends State<TrainPart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: SizedBox(
          height: size.height / 5,
          width: size.height / 6,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment(0, 1), child: Image.asset(widget.image)),
              Align(
                  alignment: Alignment(0, 0.5),
                  child: Text(
                    widget.centerWord,
                    style: TextStyle(
                        fontSize: size.height / 30,
                        fontWeight: FontWeight.bold),
                  )),
              Align(
                alignment: Alignment(-0.6, 1.2),
                child: TrainTair(),
              ),
              Align(
                alignment: Alignment(0.6, 1.2),
                child: TrainTair(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainTair extends StatelessWidget {
  const TrainTair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      "assets/images/tair.png",
      width: size.width / 52,
    );
  }
}

class BigTrainTair extends StatelessWidget {
  const BigTrainTair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      "assets/images/big_tair.png",
      width: size.width / 36,
    );
  }
}

class RailWay extends StatelessWidget {
  const RailWay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      "assets/images/rail_line.png",
      width: size.width,
      fit: BoxFit.fitWidth,
    );
  }
}
