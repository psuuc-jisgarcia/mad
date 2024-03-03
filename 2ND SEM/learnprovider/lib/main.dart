import 'package:flutter/material.dart';
import 'package:learnprovider/addscree.dart';
import 'package:learnprovider/providers/personprovider.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(Home());
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>persons(),
      child: MaterialApp(
        home: AddScreen(),
      ),
    );
  }
}