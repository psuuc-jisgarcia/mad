import 'package:flutter/material.dart';
import 'package:pro/model.dart';
import 'package:pro/providers.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
   AddScreen({super.key});
var fname=TextEditingController();
var lname=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
      ),
      body: Column(children: [
        TextField(
          controller: fname,
        ),SizedBox(height: 10,),
            TextField(
          controller: lname,
        ),
        ElevatedButton(onPressed: (){
          var pro=Provider.of<persons>(context,listen: false);
        pro.add(person(fname: fname.text, lname: lname.text, fv: false));
  Navigator.pop(context);
        print("addf");
        }, child: Text("Add"))
      ]),
    );
  }
}
class Edits extends StatefulWidget {
   Edits({super.key,required this.personEDit});
final person personEDit;

  @override
  State<Edits> createState() => _EditsState();
}

class _EditsState extends State<Edits> {
var  newFname=TextEditingController();

var  newLname=TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    newFname.text=widget.personEDit.fname;
    newLname.text=widget.personEDit.lname;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Column(children: [
        TextField(
          controller: newFname,
        ) , TextField(
          controller: newLname,
        ),
        ElevatedButton(onPressed: (){
          var pro=Provider.of<persons>(context,listen: false);
          pro.edit(widget.personEDit, newFname.text, newLname.text);
               Navigator.pop(context);
        }, child: Text("EDIT")),
   
      ]),
    );
  }
}