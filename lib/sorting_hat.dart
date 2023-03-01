import 'dart:io';
import 'dart:math';

void main() {
  int num_std = 0;
  var n_each_house = 0;
  List gryffindor = [];
  List hufflepuff = [];
  List ravenclaw = [];
  List slytherin = [];
  Random rng = new Random();

  print("Please put num of student (only number)");
  num_std = int.parse(stdin.readLineSync()!);
  //print(num_std);
  n_each_house = (num_std ~/ 4);
  print("num_H :  ${n_each_house}");
  print("Please put name of student");
  for (int i = 0; i < num_std; i++) {
    String name = stdin.readLineSync()!;
    //print(name);

    int ranhouse = rng.nextInt(4);
    //print("numHouse : ${ranhouse + 1} ");

    if (ranhouse + 1 == 1 && gryffindor.length < n_each_house) {
      gryffindor.add(name);
      print("House : Gryffindor");
    } else if (ranhouse + 1 == 2 && hufflepuff.length < n_each_house) {
      hufflepuff.add(name);
      print("House : Hufflepuff");
    } else if (ranhouse + 1 == 3 && ravenclaw.length < n_each_house) {
      ravenclaw.add(name);
      print("House : Ravenclaw");
    } else if (ranhouse + 1 == 4 && slytherin.length < n_each_house) {
      slytherin.add(name);
      print("House : Slytherin");
    } else {}
  }
  print("");
  print("Gryffindor");
  for (int i = 0; i < gryffindor.length; i++) {
    print(gryffindor[i]);
  }
  print("Hufflepuff");
  for (int i = 0; i < hufflepuff.length; i++) {
    print(hufflepuff[i]);
  }
  print("Ravenclaw");
  for (int i = 0; i < ravenclaw.length; i++) {
    print(ravenclaw[i]);
  }
  print("Slytherin");
  for (int i = 0; i < slytherin.length; i++) {
    print(slytherin[i]);
  }
}
