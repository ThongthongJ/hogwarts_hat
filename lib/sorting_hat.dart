import 'dart:io';
import 'dart:math';

void main() {
  int num_std = 0;
  List gryffindor = [];
  List hufflepuff = [];
  List ravenclaw = [];
  List slytherin = [];
  Random rng = new Random();

  print("Please put num of student (only number)");
  num_std = int.parse(stdin.readLineSync()!);
  //print(num_std);
  print("Please put name of student");
  for (int i = 0; i < num_std; i++) {
    String name = stdin.readLineSync()!;
    int ranhouse = rng.nextInt(4);
    print("House : ${ranhouse + 1} ");
    if (ranhouse == 1) {
      gryffindor.add(name);
    } else if (ranhouse == 2) {
      hufflepuff.add(name);
    } else if (ranhouse == 3) {
      ravenclaw.add(name);
    } else if (ranhouse == 4) {
      slytherin.add(name);
    }
  }
  print("house");
  // for (int i = 0; i < num_std; i++) {
  //   print(gryffindor[i]);
  // }
}
