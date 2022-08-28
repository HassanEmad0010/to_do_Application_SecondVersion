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
  List<Map> newTasksList=[];
  bool isLoading=true;

  Future<List<Map>> readDataMethod ()
  async  {

    List<Map> response=await dbObject.readData(sqlCommand: "SELECT * FROM 'TASKS'");
    newTasksList.addAll(response);
    isLoading=false;
    if(this.mounted)
      {
        setState(() { });
      }
    return response;
  }

  @override
  void initState() {
    setState(() {

    });
    super.initState();
    readDataMethod();


  }

  var newTaskScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      key: newTaskScaffoldKey,
      body:
      isLoading? const Center(child: CircularProgressIndicator(value: 30,color: Colors.white,)):
      Container(
        margin: EdgeInsets.all(24),
        //width: double.infinity,
        //height:  200,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [

                   ListView.separated(
                      separatorBuilder: (context, value) => const SizedBox(
                        height: 10,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newTasksList.length,
                      itemBuilder: (context, index) {
                        return cardBuilder(
                            snapTitle: newTasksList[index]['TITLE'],
                            snapDate: newTasksList[index]['DATE'],
                            snapStatus: newTasksList[index]['STATUS'],
                            snapTime: newTasksList[index]['TIME'],
                            longPressFunction: () async {
                              print("long pressed");
                              print("snap" + newTasksList.toString());

                              await dbObject.insertData(
                                tableName: 'DoneTASKS',
                                title: newTasksList[index]['TITLE'],
                                date: newTasksList[index]['DATE'],
                                time: newTasksList[index]['TIME'],
                                status: "Done",
                              );

                              int resp = await dbObject.DeleteData(
                                rowData: newTasksList[index]['TITLE'],
                                tableName: 'TASKS',
                              );

                              if (resp > 0) {
                                setState(() {

                                });
                                newTasksList.removeWhere((element) =>element['id']==newTasksList[index]['id'] );
                              }
                            });
                      }
                      ),

/*            Container(
              child:
              IconButton(
                iconSize: 50,
                icon: Icon(Icons.local_see),
                onPressed:(){
                  print(
                      "data from newTasksList ${newTasksList.length}");
                 // print( "data from newTasksList ${newTasksList[7]['TITLE']}");

                },
              ),




            ),*/


          ],
        ),
      ),





    );
  }
}


