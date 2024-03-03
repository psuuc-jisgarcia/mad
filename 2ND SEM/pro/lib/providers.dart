import 'package:flutter/material.dart';
import 'package:pro/model.dart';

class persons extends ChangeNotifier{
  List<person> per=[];
  List<person> get items{
    return per;
  }
  int get totalItem{
    return per.length;
  }
  void add(person p){
    per.add(p);
    notifyListeners();
  }
void tfavorites(int index){
per[index].fv=!per[index].fv;
notifyListeners();
}
void edit(person p,nfname,nlname){
  p.fname=nfname;
  p.lname=nlname;
notifyListeners();
}
}