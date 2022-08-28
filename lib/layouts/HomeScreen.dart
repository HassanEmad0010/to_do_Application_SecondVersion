import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_application/modules/DoneTaskScreen.dart';
import 'package:to_do_application/modules/DraftTaskScreen.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';
import 'package:intl/intl.dart';

import '../modules/NewTaskScreen.dart';
import '../shared/componant/componant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb myDb = SqlDb();
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  IconData floatingIcon = Icons.edit;

  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

  @override
  initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("To do App"),
        leading: const Icon(Icons.task_alt),
        iconTheme: IconThemeData(
          size: 35,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                print("delete pressed");
                await myDb.DeleteTableData(
                  tableName: 'TASKS',
                );
                await myDb.DeleteTableData(
                  tableName: 'DONETASKS',
                );
                await myDb.DeleteTableData(
                  tableName: 'DraftTASKS',
                );
                setState(() {});
              },
              icon: Icon(Icons.menu)),
        ],
      ),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});
          Navigator.of(context).pushNamed("AddTaskRoute");
        },
        child: Icon(floatingIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedLabelStyle: const TextStyle(fontSize: 22),
        selectedIconTheme: const IconThemeData(size: 30),
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {});

          currentIndex = value;
          print(currentIndex);
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.library_add), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline_sharp), label: "Done"),
          BottomNavigationBarItem(icon: Icon(Icons.drafts), label: "Draft"),
        ],
      ),
    );
  }
}
