import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../shared/componant/componant.dart';

class DraftTaskScreen extends StatefulWidget {
  @override
  State<DraftTaskScreen> createState() => _DraftTaskScreenState();
}

class _DraftTaskScreenState extends State<DraftTaskScreen> {
  SqlDb dbObject = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,

    );
  }
}