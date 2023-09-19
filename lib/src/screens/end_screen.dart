import 'package:flutter/material.dart';

import 'home.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete")),
      body: Column(
        children: [
          Container(
            child: Text(
              "Congratulations, You have complete the task",
            ),
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                    (route) => false);
              },
              child: Text("Back to Home"))
        ],
      ),
    );
  }
}
