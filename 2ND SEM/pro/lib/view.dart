import 'package:flutter/material.dart';
import 'package:pro/adds.dart';
import 'package:pro/providers.dart';
import 'package:provider/provider.dart';

class ViewS extends StatelessWidget {
  const ViewS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
      Text("ADD"),
      actions: [IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddScreen()));
      }, icon: Icon(Icons.add))],
    
      ),
      body: Consumer<persons>(
        builder: (context, value, child) {
          var prs=value.items;
          return ListView.builder(
            itemCount: value.totalItem,
            itemBuilder: (context,index){
 return Card(
  elevation: 5,
  child: ListTile(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Edits(personEDit: prs[index],)));
    },
    title:Row(
    children: [
      Text(prs[index].fname),
      SizedBox(width: 10,),Text(prs[index].lname),
    ],
  ),
  trailing: IconButton(onPressed: (){
var pro=Provider.of<persons>(context,listen: false);
pro.tfavorites(index);
  }, icon: !prs[index].fv?Icon(Icons.favorite_outline):Icon(Icons.favorite_sharp),),
  ),
 );
          });
        },
      ),
    );
  }
}