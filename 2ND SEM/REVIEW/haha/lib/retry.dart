import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>TextModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Add'),
          ),
          body: TextAdd(),
        ),
      ),
    );
  }
}

class TextModel extends ChangeNotifier{
  final TextEditingController valueA = TextEditingController();
  final TextEditingController valueB = TextEditingController();
  final List<String> list = [];

  void add (){
  final controllerA = valueA.text;
  final controllerb = valueA.text;
  list.add('$controllerA $controllerb');
  notifyListeners();
  valueA.clear();
  valueB.clear();
  }
}

class TextAdd extends StatelessWidget {
  const TextAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TextModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: model.valueA,
            decoration: InputDecoration(
              label: Text('First Name'), border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: model.valueB,
            decoration: InputDecoration(
              label: Text('First Name'), border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: ()=> model.add(), 
            child: Text('Add')
          ),
          Expanded(
            child:Consumer<TextModel>(
              builder: (context, value, child) => ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(model.list[index]),
                      trailing: Text('${index + 1}'),
                    ),
                  );
                },
              ),) )
        ],
      ),
    );
  }
}