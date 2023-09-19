// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:matching_train/src/components/background/background.dart';
import 'package:matching_train/src/models/model.dart';
import 'package:matching_train/src/components/train_parts/train_parts.dart';

import 'level_page.dart';

class TrainScreenComposed extends StatefulWidget {
  final Sentence sentence;
  const TrainScreenComposed(
      {Key? key, required this.sentence, required this.levelPageState})
      : super(key: key);
  final LevelPageState levelPageState;
  @override
  State<TrainScreenComposed> createState() => _TrainScreenComposedState();
}

class _TrainScreenComposedState extends State<TrainScreenComposed> {
  late Sentence sentence;
  @override
  void initState() {
    sentence = widget.sentence;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Background(),
        Align(
          alignment: Alignment(0, 0.9),
          child: RailWay(),
        ),
        Align(
          alignment: Alignment(-.9, -.9),
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
              Navigator.of(context).pop();
            },
            child: Text(
              "Menu",
            ),
          ),
        ),
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FullTrain(
            sentence: sentence,
            levelPageState: widget.levelPageState,
          ),
        ),
      ]),
    );
  }
}
