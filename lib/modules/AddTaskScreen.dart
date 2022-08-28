


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/modules/NewTaskScreen.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../layouts/HomeScreen.dart';
import '../shared/componant/componant.dart';

class AddTaskScreen extends StatefulWidget{

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  SqlDb dbObject= SqlDb();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var textFormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        centerTitle: true,

      ),

      body:
        Container(
          child:

          Form(
            key:textFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                  onPressed: ()async {
                    setState(() {
                    });

                    if(textFormKey.currentState!.validate())
                      {
                      var resp=  await dbObject.insertData(
                          tableName: "TASKS",
                          title: titleController.text,
                          date: timeController.text,
                          time: dateController.text,
                          status: "idle",
                        );

                      if (resp.isEmpty)
                      {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                      }

                      }




                    },
                  child: const Text('Add Note'),
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

              ],
            ),
          ),

        ),











    );

  }
}