import 'package:flutter/material.dart';
import 'package:learnprovider/model.dart';
import 'package:learnprovider/providers/personprovider.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            controller: fname,
          ), TextField(
            controller: lname,
          ),
          ElevatedButton(onPressed: (){
            var pro=Provider.of<persons>(context,listen: false);
            pro.add(person(fname: fname.text, lname: lname.text, favorite:false));
          }, child: Text("Add")),
          Expanded(child: Consumer<persons>(
            builder: (context, value, child) {
              var personsget=value.items;
              return ListView.builder(
                itemCount:value.totalitems ,
                itemBuilder: (context,index){
                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Edit(personEdit: personsget[index],)));
                    },
                    title: Row(
                      children: [
                        Text(personsget[index].fname), SizedBox(width: 10,),Text(personsget[index].lname)
                      ],
                    ),
                    trailing: IconButton(onPressed: () {
                      var pro=Provider.of<persons>(context,listen: false);
                      pro.togglefavorites(index);
                    },icon: !personsget[index].favorite?Icon(Icons.favorite_outline):Icon(Icons.favorite_sharp),),
                  ),
                );
              });
            },
          )
          ),
        ]),
      ),
    );
  }
}
@override

class Edit extends StatefulWidget {
   Edit({super.key,required this.personEdit});
final person personEdit;
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
var editFname=TextEditingController();

var editLname=TextEditingController();

@override
void initState() {
     super.initState();
  editFname.text=widget.personEdit.fname; 
editLname.text=widget.personEdit.lname; 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Column(
        children: [
          TextField(
            controller: editFname,
          ),
          TextField(
            controller: editLname,
          ),
          ElevatedButton(onPressed: (){
            var pro=Provider.of<persons>(context,listen: false);
            pro.edit(widget.personEdit, editFname.text, editLname.text);
            Navigator.pop(context);
          }, child:Text("edit"))
        ],
      ),
    );
  }
}