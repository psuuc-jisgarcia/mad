import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextBoxABModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('GG')),
          body: Center(child: TextBoxAB()),
        ),
      ),
    );
  }
}

class TextBoxABModel extends ChangeNotifier {
  final TextEditingController controllerA = TextEditingController();
  final TextEditingController controllerB = TextEditingController();
  final List<String> combinations = [];

  void addCombination() {
    final valueA = controllerA.text;
    final valueB = controllerB.text;
    combinations.add('$valueA $valueB');
    notifyListeners();
    controllerA.clear();
    controllerB.clear();
  }
}

class TextBoxAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TextBoxABModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: model.controllerA,
          decoration: InputDecoration(labelText: 'TextBox-A'),
        ),
        TextField(
          controller: model.controllerB,
          decoration: InputDecoration(labelText: 'TextBox-B'),
        ),
        ElevatedButton(
          onPressed: model.addCombination,
          child: Text('Add'),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Consumer<TextBoxABModel>(
            builder: (context, model, child) => ListView.builder(
              itemCount: model.combinations.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(model.combinations[index]),
                  trailing: Text('${index + 1}'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
