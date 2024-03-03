import 'package:flutter/material.dart';
import 'package:learnprovider/model.dart';

class persons extends ChangeNotifier{
  List<person> per=[
    person(fname: "Jerico", lname: "Garcia", favorite: false)
  ];
  int get totalitems{
    return per.length;
  }
  List<person> get items{
    return per;
  }
  void add(person p){
    per.add(p);
    notifyListeners();
  }
  void togglefavorites(int index){
    per[index].favorite=!per[index].favorite;
  notifyListeners();
  }
  void edit(person p, String newFname, String newLname) {
  p.fname = newFname;
  p.lname = newLname;
  notifyListeners();
}

}