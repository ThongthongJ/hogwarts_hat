import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HogwartsPage extends StatefulWidget {
  const HogwartsPage({Key? key}) : super(key: key);

  @override
  State<HogwartsPage> createState() => _HogwartsPageState();
}

class _HogwartsPageState extends State<HogwartsPage> {
  final _controller = TextEditingController();
  var _feedbackText = '';

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/Sorting-Hat-Download-PNG-Image.png",
                  scale: 3.2),
              //SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 480, right: 480, top: 24),
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFA8601F), width: 5.6),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFF3C83D).withOpacity(0.8),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 4.8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Please enter num of student '),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          var temp = int.tryParse(_controller.text);
                          if (temp == null) {
                            _feedbackText = 'Please enter a value.';
                            setState(() {});
                          }
                        },
                        child: Text("ENTER"),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(48.0),
                child: Text(
                  _feedbackText,
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
