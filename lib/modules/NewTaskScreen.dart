import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/models/DataModel.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../layouts/HomeScreen.dart';
import '../shared/componant/componant.dart';

//sws
class NewTaskScreen extends StatefulWidget {
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  SqlDb dbObject = new SqlDb();
  var newTaskScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      key: newTaskScaffoldKey,
      body: Container(
        margin: EdgeInsets.all(24),
        //width: double.infinity,
        //height:  200,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            FutureBuilder(
              future: dbObject.readData(sqlCommand: "SELECT * FROM 'TASKS'"),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      separatorBuilder: (context, value) => SizedBox(
                            height: 10,
                          ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return cardBuilder(
                            snapTitle: snapshot.data![index]['TITLE'],
                            snapDate: snapshot.data![index]['DATE'],
                            snapStatus: snapshot.data![index]['STATUS'],
                            snapTime: snapshot.data![index]['TIME'],
                            longPressFunction: () async {
                              print("long pressed");
                              print("snap" + snapshot.toString());

                              await dbObject.insertData(
                                tableName: 'DoneTASKS',
                                title: snapshot.data![index]['TITLE'],
                                date: snapshot.data![index]['DATE'],
                                time: snapshot.data![index]['TIME'],
                                status: "Done",
                              );

                              int resp = await dbObject.DeleteData(
//I HAVE ISSUE HERE, need to access data with the uniqe id
                                rowData: snapshot.data![index]['TITLE'],
                                tableName: 'TASKS',
                              );

                              if (resp > 0) {
                                print("navigation");
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                              }
                            });
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
