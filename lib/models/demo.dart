import 'dart:io';
import 'hogwarts_houses.dart';
import 'hogwarts_sorting_hat.dart';

void main() {
  int num_std;
  var houses = HogwartsHouses();
  var hat = HogwartsSortingHat.from(houses);

  print("Please enter num of student (only number!)");
  num_std = int.parse(stdin.readLineSync()!);
  hat.setNumStd(num_std);
  hat.setCapacityHouse();
  List cap = hat.getCapacityHouse();

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

  List house_Gryffindor = houses.getListGryffindor();
  List house_Hufflepuffr = houses.getListHufflepuff();
  List house_Ravenclaw = houses.getListRavenclaw();
  List house_Slytherin = houses.getListSlytherin();

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
