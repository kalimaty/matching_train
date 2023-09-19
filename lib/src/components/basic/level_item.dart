import 'package:flutter/material.dart';

class LevelItem extends StatelessWidget {
  final int id;
  final bool unlocked;
  final Function onPressed;

  const LevelItem(this.id, {required this.unlocked, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: unlocked ? Colors.amber.shade100 : Colors.deepOrange),
        onPressed: () => unlocked ? onPressed() : null,
        child: unlocked // المستوى غير المغلق  يتم عرض رقم المستوى
            ? Text(
                (id).toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              )
            : Icon(
                Icons.lock,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
      ),
    );
  }
}
