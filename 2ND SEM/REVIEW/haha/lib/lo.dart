import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextModel(),
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

class TextModel extends ChangeNotifier {
  final TextEditingController valueA = TextEditingController();
  final TextEditingController valueB = TextEditingController();
  final List<Color> colors = List.filled(100, Colors.white);
  final List<String> list = [];

  void add() {
    final controllerA = valueA.text;
    final controllerB = valueB.text;
    list.add('$controllerA $controllerB');
    notifyListeners();
    valueA.clear();
    valueB.clear();
  }

  void changeColor(int index, Color color) {
    colors[index] = color;
    notifyListeners();
  }
}


class TextAdd extends StatelessWidget {
  const TextAdd({Key? key}) : super(key: key);

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
                labelText: 'First Name', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            controller: model.valueB,
            decoration: InputDecoration(
                labelText: 'Last Name', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => model.add(),
            child: Text('Add'),
          ),
          Expanded(
            child: Consumer<TextModel>(
              builder: (context, model, child) => ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorPage(
                            index: index,
                            model: model,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: model.colors[index],
                      child: ListTile(
                        title: Text(model.list[index]),
                        trailing: Text('${index + 1}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorPage extends StatelessWidget {
  final int index;
  final TextModel model;

  const ColorPage({required this.index, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Color'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                model.changeColor(index, Colors.blue);
                Navigator.pop(context);
              },
              child: Text('Blue'),
            ),
            ElevatedButton(
              onPressed: () {
                model.changeColor(index, Colors.red);
                Navigator.pop(context);
              },
              child: Text('Red'),
            ),
          ],
        ),
      ),
    );
  }
}

