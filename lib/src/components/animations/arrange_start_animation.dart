import 'dart:math';

import 'package:flutter/material.dart';
 

class ArrangeStartAnimation extends StatefulWidget {
  final Widget child;
  const ArrangeStartAnimation({Key? key, required this.child})
      : super(key: key);

  @override
  State<ArrangeStartAnimation> createState() => _ArrangeStartAnimationState();
}

class _ArrangeStartAnimationState extends State<ArrangeStartAnimation>
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
        Tween(begin: Offset(dx, dy), end: Offset(0, 0)).animate(controller);
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
