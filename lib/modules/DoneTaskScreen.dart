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
      body: Container(
        margin: EdgeInsets.all(24),
        //width: double.infinity,
        //height:  200,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            FutureBuilder(
              future:
                  dbObject.readData(sqlCommand: "SELECT * FROM 'DONETASKS'"),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      separatorBuilder: (context, value) => const SizedBox(
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
                              setState(() {});
                              print("long pressed");
                              print("snap" + snapshot.toString());

                              await dbObject.insertData(
                                tableName: 'DraftTASKS',
                                title: snapshot.data![index]['TITLE'],
                                date: snapshot.data![index]['DATE'],
                                time: snapshot.data![index]['TIME'],
                                status: "Draft",
                              );

                              int resp = await dbObject.DeleteData(
//I HAVE ISSUE HERE, need to access data with the uniqe id
                                rowData: snapshot.data![index]['TITLE'],
                                tableName: 'DONETASKS',
                              );

                              /* if(resp>0)
                              {
                                print("navigation");
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder:
                                        (context)=>DoneTaskScreen(),
                                    )
                                );
                              }*/
                            });
                      });
                } else {
                  return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.red, value: 40),
                    widthFactor: 50,
                    heightFactor: 40,
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