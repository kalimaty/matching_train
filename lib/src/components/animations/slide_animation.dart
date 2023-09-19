import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final Offset offset;
  const SlideAnimation(
      {Key? key, required this.child, this.offset = const Offset(0, 0)})
      : super(key: key);

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    Random rand = Random();
    double dx = rand.nextDouble() * 2 * (rand.nextBool() ? -1 : 1);
    double dy = rand.nextDouble() * 2 * (rand.nextBool() ? -1 : 1);
    animation =
        Tween(begin: widget.offset, end: Offset(0, 0)).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: widget.child,
    );
  }
}
