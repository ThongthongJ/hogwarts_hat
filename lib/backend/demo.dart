import 'dart:io';
import 'package:hogwarts_hat/backend/hogwarts_houses.dart';
import 'package:hogwarts_hat/backend/hogwarts_sorting_hat.dart';

void main() {
  int num_std;
  var houses = HogwartsHouses();
  var hat = HogwartsSortingHat(houses);

  print("Please enter num of student (only number!)");
  num_std = int.parse(stdin.readLineSync()!);
  hat.setNum_std(num_std);
  hat.setCapacity_house();
  List cap = hat.getCapacity_house();

  for (int i = 0; i < 4; i++) {
    print("Capacity of house${i + 1}: ${cap[i]}");
  }

  print("Please enter name of student");
  for (int std = 0; std < num_std; std++) {
    String name = stdin.readLineSync()!;
    String shortNameHouse = hat.randomHouse();
    //print(house);
    String nameHouse = hat.sortingHat(shortNameHouse, name);
    print(nameHouse);
  }

  List house_Gryffindor = houses.getList_Gryffindor();
  List house_Hufflepuffr = houses.getList_Hufflepuff();
  List house_Ravenclaw = houses.getList_Ravenclaw();
  List house_Slytherin = houses.getList_Slytherin();

  print("");
  print("Student of Gryffindor House :");
  for (int std = 0; std < house_Gryffindor.length; std++) {
    print(house_Gryffindor[std]);
  }

  print("Student of Hufflepuff House :");
  for (int std = 0; std < house_Hufflepuffr.length; std++) {
    print(house_Hufflepuffr[std]);
  }

  print("Student of Ravenclaw House :");
  for (int std = 0; std < house_Ravenclaw.length; std++) {
    print(house_Ravenclaw[std]);
  }

  print("Student of Slytherin House :");
  for (int std = 0; std < house_Slytherin.length; std++) {
    print(house_Slytherin[std]);
  }
}
