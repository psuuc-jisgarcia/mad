import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main ()async{
  await Hive.initFlutter();
  await Hive.openBox('texts');
  runApp(Screen());
}

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Etona(),
    );
  }
}

class Etona extends StatefulWidget {
  const Etona({super.key});

  @override
  State<Etona> createState() => _EtonaState();
}

class _EtonaState extends State<Etona> {
  final TextEditingController add = TextEditingController();

  void addtext()async{
    final box = await Hive.openBox('texts');
    if(add.text.isNotEmpty){
      box.add(add.text);
      add.clear();
      setState(() {
      });
    }
  }

  void delete() async{
    final box = await Hive.openBox('texts');
    box.clear();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: delete, 
            icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: add,
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
          ElevatedButton(onPressed: addtext, child: Text('Add')),
          Expanded(child: 
          ValueListenableBuilder(
            valueListenable: Hive.box('texts').listenable(), 
            builder: (context, box, _){
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Text(box.get(index)),
                    ),
                  );
                });
            }))
        ],
      ),
    );
  }

  @override
  void dispose(){
    add.dispose();
    super.dispose();
  }
}