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
  SqlDb myDb = new SqlDb();
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFloatingPressed = false;
  IconData floatingIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var textFormKey = GlobalKey<FormState>();

  // late Future<List<Map<String, Object?>>> homeTasks;

  List<Widget> Screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    DraftTaskScreen(),
  ];

  @override
  initState() {
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

          if (isFloatingPressed && (textFormKey.currentState!.validate())) {
            //'INSERT INTO TASKS(TITLE,DATE,TIME,STATUS) VALUES("$task", "pray", "25-8-2022","$status")'
            var responce = await myDb
                .insertData(
              tableName: "TASKS",
              title: titleController.text,
              date: dateController.text,
              status: "idle",
              time: timeController.text,
            )
                .then((value) {
              setState(() {});
            });

            print("inserting from feilds " + responce.toString());
            Navigator.of(context).pop();
            isFloatingPressed = false;
            print("floating $isFloatingPressed");
            setState(() {
              floatingIcon = Icons.edit;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note Added')),
              );
            });

            titleController.text = "";
            timeController.text = "";
            dateController.text = "";
          } else {
            setState(() {
              floatingIcon = Icons.add;
            });
            scaffoldKey.currentState
                ?.showBottomSheet(
                    backgroundColor: Colors.black54, elevation: 15,

                    //enableDrag: false,

                    (context) {
                  isFloatingPressed = true;
                  print("floating $isFloatingPressed");




                  return Container(
                    padding: const EdgeInsets.all(19),
                    color: Colors.white,
                    child: Form(
                      key: textFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          textFormField(
                            formFieldText: "Task Title",
                            textEditingController: titleController,
                            onTabFunction: () {
                              print("title tabbed");
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "title Cant be empty";
                              }
                              return null;
                            },
                            iconPrefix: Icons.text_snippet,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          textFormField(
                            textInputType: TextInputType.numberWithOptions(),
                            onTabFunction: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                if (value != null) {
                                  timeController.text =
                                      value.format(context).toString();
                                  print("value is $value");
                                } else {
                                  return null;
                                }
                                setState(() {});
                              });
                            },
                            formFieldText: "Time",
                            iconPrefix: Icons.timer_outlined,
                            textEditingController: timeController,
                            validator: (String? value) {},
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          textFormField(
                            textEditingController: dateController,
                            formFieldText: "Date",
                            iconPrefix: Icons.date_range_outlined,
                            validator: (String? value) {},
                            onTabFunction: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.utc(2022, 08, 30),
                              ).then((value) {
                                setState(() {});
                                if (value != null) {
                                  var dat = DateFormat.yMMMd().format(value);
                                  dateController.text = dat.toString();
                                  print("Date is $dat");
                                }
                              });
                            },
                          ),

                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                titleController.text = "";
                                timeController.text = "";
                                dateController.text = "";

                                // isFloatingPressed = false;
                                // floatingIcon=Icons.edit;

                                // print(isFloatingPressed);
                              });
                            },
                            child: const Text('clear data'),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     setState(() {
                          //
                          //     //  print(homeTasks.toString());
                          //
                          //     });
                          //
                          //   },
                          //   child: const Text('test'),
                          // ),
                        ],
                      ),
                    ),
                  );
                })
                .closed
                .then((value) {
                  setState(() {
                    isFloatingPressed = false;
                    floatingIcon = Icons.edit;
                  });
                });
          }
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
