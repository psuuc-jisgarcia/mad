import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:madquiz2prac/homescreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // sa una ang iimport niya is adapter, palitan mo pero ng hive_flutter (nasa recording ni sir)
  runApp(const name());
}
class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home(),
    );
  }
}
// STEP BY STEP
// import 2 dependencies hive, hive_flutter
// import 2 dev dependencies hive_generator,builder_runner
// build ui
// open box nasa void to
// fetch
// 