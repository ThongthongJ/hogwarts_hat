import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/hogwarts_houses.dart';
import '../models/hogwarts_sorting_hat.dart';

class HogwartsPage extends StatefulWidget {
  const HogwartsPage({Key? key}) : super(key: key);

  @override
  State<HogwartsPage> createState() => _HogwartsPageState();
}

enum AppState { EnteringNumber, EnteringName, Done, ShowResult, Exit }

class _HogwartsPageState extends State<HogwartsPage> {
  final _controllerNum = TextEditingController();
  final _controllerName = TextEditingController();
  var _feedbackText = '';
  int _check_n_std = 0;
  HogwartsHouses _houses = HogwartsHouses();
  var _hat = HogwartsSortingHat();
  List _capacity = [];
  List _gryffindor = [];
  List _hufflepuff = [];
  List _ravenclaw = [];
  List _slytherin = [];
  bool _cack_show_houses = true;
  AppState appState = AppState.EnteringNumber;

  @override
  void initState() {
    this._hat = HogwartsSortingHat.from(_houses);
    List _gryffindor = _houses.getListGryffindor();
    List _hufflepuff = _houses.getListHufflepuff();
    List _ravenclaw = _houses.getListRavenclaw();
    List _slytherin = _houses.getListSlytherin();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputWidget;
    Widget buttonWidget;

    Widget _buidListItemG(BuildContext context, int index) {
      var _G = _houses.getListGryffindor()[index];
      return Text(_G);
    }

    if (appState == AppState.EnteringNumber) {
      inputWidget = TextField(
          controller: _controllerNum,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Please enter number of student '));
      buttonWidget = ElevatedButton(
        onPressed: () {
          var numStd = int.tryParse(_controllerNum.text);
          if (numStd == null) {
            setState(() {
              _feedbackText = 'Please enter a Number of Student.';
              _controllerNum.text = "";
            });
          } else if (numStd <= 0) {
            setState(() {
              _feedbackText = 'Please enter a number greater than Zero.';
              _controllerNum.text = "";
            });
          } else {
            setState(() {
              _hat.setNumStd(numStd);
              _hat.setCapacityHouse();
              _capacity = _hat.getCapacityHouse();
              _feedbackText = 'The number of students : ${_hat.getNumStd()}';
              _controllerNum.text = "";
              appState = AppState.EnteringName;
            });
          }
        },
        child: Text("ENTER"),
      );
    } else if (appState == AppState.EnteringName) {
      inputWidget = TextField(
          controller: _controllerName,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Please enter name of student '));
      buttonWidget = ElevatedButton(
          onPressed: () {
            var nameStd = _controllerName.text;
            String shortNameHouse = _hat.randomHouse();
            if (_check_n_std < _hat.getNumStd()) {
              String house = _hat.sortingHat(shortNameHouse, nameStd);
              _feedbackText = house;
              _controllerName.text = "";
              _check_n_std++;
            }
            if (_check_n_std >= _hat.getNumStd()) {
              _controllerName.text = "";
              _feedbackText = "";
              appState = AppState.Done;
            }
            setState(() {});
          },
          child: Text("ENTER"));
    } else if (appState == AppState.Done) {
      inputWidget = Text(
        "Welcome To Hogwarts",
        style: TextStyle(fontSize: 48.0),
      );
      buttonWidget = ElevatedButton(
          onPressed: () {
            setState(() {
              appState = AppState.ShowResult;
              _feedbackText = "";
              _controllerName.text = "";
              _cack_show_houses = true;
            });
          },
          child: Text("DONE"));
    } else if (appState == AppState.Exit) {
      inputWidget = Text(
        "Welcome To Hogwarts",
        style: TextStyle(fontSize: 48.0),
      );
      buttonWidget = ElevatedButton(
          onPressed: () {
            setState(() {
              appState = AppState.ShowResult;
              _feedbackText = "";
              _controllerName.text = "";
              _cack_show_houses = true;
            });
          },
          child: Text("Exit"));
    } else {
      inputWidget = SizedBox.shrink();
      buttonWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _houses.resetHouse();
                  appState = AppState.EnteringName;
                  _check_n_std = 0;
                });
              },
              child: Text("Reset")),
          SizedBox(width: 8),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  print(_houses.getListGryffindor());
                  print(_houses.getListHufflepuff());
                  print(_houses.getListRavenclaw());
                  print(_houses.getListSlytherin());
                  _cack_show_houses = false;
                  appState = AppState.Exit;
                });
              },
              child: Text("Show")),
        ],
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.8,
            image: AssetImage("assets/images/hall.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              _cack_show_houses
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            "assets/images/Sorting-Hat-Download-PNG-Image.png",
                            scale: 4.0),
                        //SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.3,
                              right: MediaQuery.of(context).size.width * 0.3,
                              top: 8,
                              bottom: 16),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0xFFA8601F), width: 5.6),
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
                                    child: inputWidget),
                                buttonWidget,
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _feedbackText,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset("assets/images/pngwing.png", scale: 8),
                      ],
                    )
                  : Positioned(
                      top: 100,
                      bottom: 100,
                      left: 100,
                      right: 100,
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 24, right: 32),
                                  child: buttonWidget,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFFD00001), width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFEEBA30)
                                              .withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 4.8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Gryffindor",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFFF0C75E), width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF726255)
                                              .withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 4.8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Hufflepuff",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFF314077), width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF5D5D5D)
                                              .withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 4.8),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      "Ravenclaw",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFF2A623D), width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF5D5D5D)
                                              .withOpacity(0.4),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 4.8),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      "Slytherin",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
