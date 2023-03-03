import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/hogwarts_houses.dart';
import '../models/hogwarts_sorting_hat.dart';

class HogwartsPage extends StatefulWidget {
  const HogwartsPage({Key? key}) : super(key: key);

  @override
  State<HogwartsPage> createState() => _HogwartsPageState();
}

enum AppState { EnteringNumber, EnteringName, Done, ShowResult }

class _HogwartsPageState extends State<HogwartsPage> {
  final _controllerNum = TextEditingController();
  final _controllerName = TextEditingController();
  var _feedbackText = '';
  int _check_n_std = 0;
  HogwartsHouses _houses = HogwartsHouses();
  var _hat = HogwartsSortingHat();
  List _capacity = [];
  AppState appState = AppState.EnteringNumber;

  @override
  void initState() {
    this._hat = HogwartsSortingHat.from(_houses);
  }

  @override
  Widget build(BuildContext context) {
    Widget inputWidget;
    Widget buttonWidget;

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
          } else {
            setState(() {
              _hat.setNumStd(numStd);
              _hat.setCapacityHouse();
              _capacity = _hat.getCapacityHouse();
              _feedbackText = 'Value : ${_hat.getNumStd()}';
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
              appState = AppState.Done;
            }
            setState(() {});
          },
          child: Text("ENTER"));
    } else if (appState == AppState.Done) {
      inputWidget = Text(
        "Welcome TO Hogwarts",
        style: TextStyle(fontSize: 48.0),
      );
      buttonWidget = ElevatedButton(
          onPressed: () {
            setState(() {
              appState = AppState.ShowResult;
              _feedbackText = "";
            });
          },
          child: Text("DONE"));
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
            opacity: 0.9,
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
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.3,
                    right: MediaQuery.of(context).size.width * 0.3,
                    top: 24),
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
                      buttonWidget
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
