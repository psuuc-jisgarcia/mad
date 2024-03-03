import 'package:flutter/material.dart';
import 'package:pro/providers.dart';
import 'package:pro/view.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(Home());
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>persons(),
      child: MaterialApp(
        home: ViewS(),
      ),
    );
  }
}