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

  List getList_Gryffindor() {
    return _gryffindor;
  }

  List getList_Hufflepuff() {
    return _hufflepuff;
  }

  List getList_Ravenclaw() {
    return _ravenclaw;
  }

  List getList_Slytherin() {
    return _slytherin;
  }
}
