import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HogwartsPage extends StatefulWidget {
  const HogwartsPage({Key? key}) : super(key: key);

  @override
  State<HogwartsPage> createState() => _HogwartsPageState();
}

class _HogwartsPageState extends State<HogwartsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/hall.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
