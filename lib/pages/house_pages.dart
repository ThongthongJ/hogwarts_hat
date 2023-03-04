import 'package:flutter/material.dart';

class HousePage extends StatefulWidget {
  var students;
  String houseName;

  HousePage({Key? key, required this.students, required this.houseName})
      : super(key: key);

  @override
  State<HousePage> createState() => _GryffindorPageState();
}

class _GryffindorPageState extends State<HousePage> {
  @override
  Widget _buidListItemG(BuildContext context, int index) {
    var _G = widget.students[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          _G,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var sColor;
    var image = Image.asset('assets/images/pngwing.png');

    if (widget.houseName == 'Gryffindor') {
      sColor = Colors.red;
      image = Image.asset('assets/images/Sorting-Hat-Download-PNG-Image.png');
    } else if (widget.houseName == 'Hufflepuff') {
      sColor = Color(0xF4C2AD51);
      image = Image.asset('assets/images/Sorting-Hat-Download-PNG-Image.png');
    } else if (widget.houseName == 'Ravenclaw') {
      sColor = Color(0xF43A76D0);
      image = Image.asset('assets/images/Sorting-Hat-Download-PNG-Image.png');
    } else if (widget.houseName == 'Slytherin') {
      sColor = Color(0xFF027918);
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.houseName), backgroundColor: sColor),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            scale: 0.5,
            opacity: 0.5,
            image: AssetImage(
              "assets/images/pngwing.png",
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                // ใช้แสดงวิดเจทซ้อนบนหน้าจอ
                children: [
                  ListView.builder(
                    itemBuilder: _buidListItemG,
                    itemCount: widget.students.length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
