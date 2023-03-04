import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hogwarts_hat/pages/g.dart';

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
  int _checkG = 0;
  int _checkH = 0;
  int _checkR = 0;
  int _checkS = 0;
  String house = "";
  HogwartsHouses _houses = HogwartsHouses();
  var _hat = HogwartsSortingHat();
  List _capacity = [];
  List _gryffindor = [];
  List _hufflepuff = [];
  List _ravenclaw = [];
  List _slytherin = [];
  AppState appState = AppState.EnteringNumber;

  @override
  void initState() {
    this._hat = HogwartsSortingHat.from(_houses);
  }

  Future<void> _showMyDialog() async {
    _gryffindor = _houses.getListGryffindor();
    _hufflepuff = _houses.getListHufflepuff();
    _ravenclaw = _houses.getListRavenclaw();
    _slytherin = _houses.getListSlytherin();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Gryffindor", style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Hufflepuff", style: TextStyle(fontSize: 24)),
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          for (int i = 0; i < _hufflepuff.length; i++)
                            Text(_hufflepuff[i])
                        ]))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Ravenclaw", style: TextStyle(fontSize: 24)),
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          for (int i = 0; i < _ravenclaw.length; i++)
                            Text(_ravenclaw[i])
                        ]))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Slytherin",
                      style: TextStyle(fontSize: 24),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          for (int i = 0; i < _slytherin.length; i++)
                            Text(_slytherin[i])
                        ]))
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget inputWidget;
    Widget buttonWidget;
    Widget showListG;

    if (_checkG < _gryffindor.length) {
      for (int i = 0; i < _gryffindor.length; i++) {
        var nameG = _gryffindor[i];
        showListG = Text(_gryffindor[i]);
      }
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
              house = _hat.sortingHat(shortNameHouse, nameStd);
              _feedbackText = house;
              _controllerName.text = "";
              _check_n_std++;
            }
            if (_check_n_std >= _hat.getNumStd()) {
              _controllerName.text = "";
              _feedbackText = house;
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HousePage(
                          students: _houses.getListGryffindor(),
                          houseName: 'Gryffindor',
                        )),
                  );
                });
              },
              child: Text("Show Gryffindor")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  print(_houses.getListGryffindor());
                  print(_houses.getListHufflepuff());
                  print(_houses.getListRavenclaw());
                  print(_houses.getListSlytherin());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HousePage(
                          students: _houses.getListHufflepuff(),
                          houseName: 'Hufflepuff',
                        )),
                  );
                });
              },
              child: Text("Show Hufflepuff")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  print(_houses.getListGryffindor());
                  print(_houses.getListHufflepuff());
                  print(_houses.getListRavenclaw());
                  print(_houses.getListSlytherin());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HousePage(
                          students: _houses.getListRavenclaw(),
                          houseName: 'Ravenclaw',
                        )),
                  );
                });
              },
              child: Text("Show Ravenclaw")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  print(_houses.getListGryffindor());
                  print(_houses.getListHufflepuff());
                  print(_houses.getListRavenclaw());
                  print(_houses.getListSlytherin());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HousePage(
                          students: _houses.getListSlytherin(),
                          houseName: 'Slytherin',
                        )),
                  );
                });
              },
              child: Text("Show Slytherin")),
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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/Sorting-Hat-Download-PNG-Image.png",
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
                        child: inputWidget),
                    buttonWidget,
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _feedbackText,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Image.asset("assets/images/pngwing.png", scale: 8),
          ],
        )),
      ),
    );
  }
}
