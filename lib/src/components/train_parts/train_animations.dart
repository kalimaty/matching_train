import 'package:flutter/material.dart';

class TrainPartDropAnimation extends StatefulWidget {
  const TrainPartDropAnimation(
      {Key? key,
      required this.child,
      required this.numOfAns,
      required this.offsetX})
      : super(key: key);
  final Widget child;
  final int numOfAns;
  final double offsetX;
  @override
  State<TrainPartDropAnimation> createState() => _TrainPartDropAnimationState();
}

class _TrainPartDropAnimationState extends State<TrainPartDropAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = Tween(begin: 0.5, end: 0.0).animate(controller);
    // TODO: implement initState
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    late double leftPadding;
    if (widget.offsetX > (size.width - (size.width / 5) * widget.numOfAns)) {
      leftPadding =
          widget.offsetX - (size.width - (size.width / 5) * widget.numOfAns);
      if (leftPadding > size.width) leftPadding = 100;
    } else {
      // print("Else Worked");
      leftPadding = (size.width - (size.width / 5) * widget.numOfAns);
    }
    // leftPadding = (size.width - (size.width / 5) * widget.numOfAns);
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(left: leftPadding * animation.value),
            child: widget.child,
          );
        });
  }
}

class TrainPartBeginingAnimation extends StatefulWidget {
  const TrainPartBeginingAnimation({Key? key}) : super(key: key);

  @override
  State<TrainPartBeginingAnimation> createState() =>
      _TrainPartBeginingAnimationState();
}

class _TrainPartBeginingAnimationState
    extends State<TrainPartBeginingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
