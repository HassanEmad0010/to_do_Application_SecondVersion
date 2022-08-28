import 'package:flutter/material.dart';
import 'package:to_do_application/modules/NewTaskScreen.dart';

import 'layouts/HomeScreen.dart';
import 'modules/AddTaskScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {"AddTaskRoute":(context)=>AddTaskScreen() },
    );
  }
}
