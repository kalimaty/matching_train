import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      "assets/images/background.jpg",
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
    );
  }
}
