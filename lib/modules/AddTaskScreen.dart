import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/modules/NewTaskScreen.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../layouts/HomeScreen.dart';
import '../shared/componant/componant.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  SqlDb dbObject = SqlDb();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var textFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.all(26),
              child: Form(
                key: textFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    textFormField(
                      color: Colors.black,

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
                      color: Colors.black,

                      textInputType: TextInputType.none,
                      onTabFunction: () {
                        showTimePicker(context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value != null) {
                            timeController.text = value.format(context).toString();
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
                      color: Colors.black,
                      textInputType: TextInputType.none,
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.green,)),
                          onPressed: () async {
                            setState(() {});

                            if (textFormKey.currentState!.validate()) {
                              var resp = await dbObject.insertData(
                                tableName: "TASKS",
                                title: titleController.text,
                                date: timeController.text,
                                time: dateController.text,
                                status: "idle",
                              );
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => HomeScreen()),
                                    (route) => false);

                            }
                          },

                          child: const Text('Add Note'),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.green,)),

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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
