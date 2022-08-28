import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layouts/HomeScreen.dart';
import '../shared/componant/DataBaseClass.dart';
import '../shared/componant/componant.dart';

class DoneTaskScreen extends StatefulWidget {
  @override
  State<DoneTaskScreen> createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends State<DoneTaskScreen> {
  SqlDb dbObject = new SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,

    );
  }
}
