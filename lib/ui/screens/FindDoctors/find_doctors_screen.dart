import 'package:flutter/material.dart';
import "dart:collection";

class FindDoctorsBackground extends StatefulWidget {
  const FindDoctorsBackground({Key key}) : super(key: key);

  @override
  _FindDoctorsBackgroundState createState() => _FindDoctorsBackgroundState();
}

class Customer {
  String name;
  int age;
  int test;

  Customer(this.name, this.age, this.test);

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} , ${this.test}}';
  }
}

class _FindDoctorsBackgroundState extends State<FindDoctorsBackground> {
  int main() {
    HashMap map = new HashMap<String, int>();
    map['knee'] = 60;
    map['head'] = 10;
    map['arm'] = 5;
    map['leg'] = 11;
    map['toe'] = 1;
    map['toe'] = 13;

    print(map);

    LinkedHashMap sortListMap(HashMap map) {
      List mapKeys = map.keys.toList(growable: false);
      mapKeys.sort((k1, k2) => map[k2] - map[k1]);
      LinkedHashMap resMap = new LinkedHashMap();
      mapKeys.forEach((k1) {
        resMap[k1] = map[k1];
      });
      return resMap;
    }

    LinkedHashMap sortedMap = sortListMap(map);

    print(sortedMap);

    var list = [];
    var numList = [1, 2, 3];
    int x = 0;
    sortedMap.forEach((bodyPart, frequency) => {
          list.add(Customer(bodyPart, frequency, numList[x])),
          x++,
        });

    print(list);
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("To be completed by 1st August"),
    );
  }
}
