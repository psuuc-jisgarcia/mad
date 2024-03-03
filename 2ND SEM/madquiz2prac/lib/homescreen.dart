import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> list = [];
  var ctrl = TextEditingController();

  Future<void> add() async {
    var box = await Hive.openBox('boxname');
    list.add(ctrl.text);
    box.put('list', list);
    setState(() {});
  }
  Future<void> fetchList()async{
    var box = await Hive.openBox('boxname');
    if(box.get('list') != null){
      list = (box.get('list') as List).map((e) => e.toString()).toList();
    }
        print(box.get('list'));
  } 
  Future<void> clear() async {
    list.clear();
    var box = await Hive.openBox('boxname');
    box.put('list', list);
    list.clear();
    setState(() {
      
    });
  }
  @override
  void initState() {
    
    super.initState();
    fetchList().then((value) {
      setState(() {
        
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: ctrl,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          ElevatedButton(onPressed: add, child: Text('add')),
          ElevatedButton(onPressed: clear, child: Text('clear')),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) => ListTile(
                title: Text(list[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
