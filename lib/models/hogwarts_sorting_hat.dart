import 'dart:math';

import 'hogwarts_houses.dart';

class HogwartsSortingHat {
  int _num_std = 0;
  int _n_each_house = 0;
  List _shortName_house = ['G', 'H', 'R', 'S'];
  List _capcity_house = [];
  List _temp_house = [];
  bool _houseFull = false;
  var _hogwart_house;
  Random _rng = new Random();

  HogwartsSortingHat() {}

  HogwartsSortingHat.from(HogwartsHouses objHouse) {
    this._hogwart_house = objHouse;
  }

  void setNumStd(int num) {
    this._num_std = num;
  }

  int getNumStd() {
    return this._num_std;
  }

  void setCapacityHouse() {
    if (_num_std < 4) {
      this._n_each_house = 1;
    } else {
      this._n_each_house = (this._num_std ~/ 4);
    }
    for (int i = 0; i < 4; i++) {
      _capcity_house.add(_n_each_house);
    }
  }

  List getCapacityHouse() {
    return _capcity_house;
  }

  String randomHouse() {
    String _ranhouse = "";
    //print("check remain house : ${_shortName_house.length}");
    if (_shortName_house.isNotEmpty) {
      _ranhouse = _shortName_house[_rng.nextInt(_shortName_house.length)];
      _houseFull = false;
    } else {
      _ranhouse = _temp_house[_rng.nextInt(_temp_house.length)];
      _houseFull = true;
    }
    return _ranhouse;
  }

  String sortingHat(String nameH, String nameStd) {
    String _nameHouse = nameH;
    String _str = "";
    //houses is full
    if (_houseFull) {
      if (_nameHouse == 'G') {
        _hogwart_house.addToGryffindor(nameStd);
        _temp_house.remove('G');
        _str = "House : Gryffindor";
      } else if (_nameHouse == 'H') {
        _hogwart_house.addToHufflepuf(nameStd);
        _temp_house.remove('H');
        _str = "House : Hufflepuf";
      } else if (_nameHouse == 'R') {
        _hogwart_house.addToRavenclaw(nameStd);
        _temp_house.remove('R');
        _str = "House : Ravenclaw";
      } else if (_nameHouse == 'S') {
        _hogwart_house.addToSlytherin(nameStd);
        _temp_house.remove('S');
        _str = "House : Slytherin";
      }
    } else {
      //Gryffindor
      if (_nameHouse == 'G') {
        if (_hogwart_house.getListGryffindor().length < _n_each_house) {
          _hogwart_house.addToGryffindor(nameStd);
          _capcity_house[0]--;
          _str = "House : Gryffindor";
        }
        if (_capcity_house[0] <= 0) {
          _shortName_house.remove('G');
          _temp_house.add('G');
        }
      }
      //Hufflepuff
      else if (_nameHouse == 'H') {
        if (_hogwart_house.getListHufflepuff().length < _n_each_house) {
          _hogwart_house.addToHufflepuf(nameStd);
          _capcity_house[1]--;
          _str = "House : Hufflepuf";
        }
        if (_capcity_house[1] <= 0) {
          _shortName_house.remove('H');
          _temp_house.add('H');
        }
      }
      //Ravenclaw
      else if (_nameHouse == 'R') {
        if (_hogwart_house.getListRavenclaw().length < _n_each_house) {
          _hogwart_house.addToRavenclaw(nameStd);
          _capcity_house[2]--;
          _str = "House : Ravenclaw";
        }
        if (_capcity_house[2] <= 0) {
          _shortName_house.remove('R');
          _temp_house.add('R');
        }
      }
      //Slytherin
      else if (_nameHouse == 'S') {
        if (_hogwart_house.getListSlytherin().length < _n_each_house) {
          _hogwart_house.addToSlytherin(nameStd);
          _capcity_house[3]--;
          _str = "House : Slytherin";
        }
        if (_capcity_house[3] <= 0) {
          _shortName_house.remove('S');
          _temp_house.add('S');
        }
      }
    }
    return _str;
  }
}
