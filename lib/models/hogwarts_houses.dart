class HogwartsHouses {
  List _gryffindor = [];
  List _hufflepuff = [];
  List _ravenclaw = [];
  List _slytherin = [];

  HogwartsHouses() {}

  void addToGryffindor(String nameStd) {
    this._gryffindor.add(nameStd);
  }

  void addToHufflepuf(String nameStd) {
    this._hufflepuff.add(nameStd);
  }

  void addToRavenclaw(String nameStd) {
    this._ravenclaw.add(nameStd);
  }

  void addToSlytherin(String nameStd) {
    this._slytherin.add(nameStd);
  }

  List getListGryffindor() {
    return _gryffindor;
  }

  List getListHufflepuff() {
    return _hufflepuff;
  }

  List getListRavenclaw() {
    return _ravenclaw;
  }

  List getListSlytherin() {
    return _slytherin;
  }

  void resetHouse() {
    _gryffindor.clear();
    _hufflepuff.clear();
    _ravenclaw.clear();
    _slytherin.clear();
  }
}
