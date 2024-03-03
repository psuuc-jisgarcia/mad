import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Name {
  String firstName;
  String lastName;

  Name({required this.firstName, required this.lastName});
}

class NameData extends ChangeNotifier {
  List<Name> names = [];

  void addName(String firstName, String lastName) {
    names.add(Name(firstName: firstName, lastName: lastName));
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NameData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Name Entry App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final nameData = Provider.of<NameData>(context, listen: false);
                nameData.addName(
                    _firstNameController.text, _lastNameController.text);
                _firstNameController.clear();
                _lastNameController.clear();
              },
              child: Text('Add'),
            ),
            SizedBox(height: 20),
            Consumer<NameData>(
              builder: (context, nameData, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: nameData.names.length,
                    itemBuilder: (context, index) {
                      return Card(
                      child:  ListTile(
                        title: Text("${nameData.names[index].firstName} ${nameData.names[index].lastName}"),),
                     

                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
