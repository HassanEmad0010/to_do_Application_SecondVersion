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
  List doneTasksList=[];
  bool isLoading=true;
  var doneTaskScaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Map>> readDataMethod ()
  async  {

    List<Map> response=await dbObject.readData(sqlCommand: "SELECT * FROM 'DONETASKS'");
    doneTasksList.addAll(response);
    isLoading=false;
    if(this.mounted)
    {
      setState(() { });
    }
    return response;
  }
  @override
  void initState() {
    super.initState();
    readDataMethod();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      key: doneTaskScaffoldKey,
      body:
      isLoading?
      const Center(child: CircularProgressIndicator(value: 60,),
      ):
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
                itemCount: doneTasksList.length,
                itemBuilder: (context, index) {
                  return cardBuilder(
                      snapTitle: doneTasksList[index]['TITLE'],
                      snapDate: doneTasksList[index]['DATE'],
                      snapStatus: doneTasksList[index]['STATUS'],
                      snapTime: doneTasksList[index]['TIME'],
                      PressFunction: () async {
                        print("long pressed");
                        print("snap" + doneTasksList.toString());

                        await dbObject.insertData(
                          tableName: 'DraftTASKS',
                          title: doneTasksList[index]['TITLE'],
                          date: doneTasksList[index]['DATE'],
                          time: doneTasksList[index]['TIME'],
                          status: "Draft",
                        );

                        int resp = await dbObject.DeleteData(
                          rowData: doneTasksList[index]['TITLE'],
                          tableName: 'DONETASKS',
                        );

                        if (resp > 0) {
                          setState(() {

                          });
                          doneTasksList.removeWhere((element) =>element['id']==doneTasksList[index]['id'] );
                        }
                      }, longPressFunction: () {  });
                }
            ),

         /*   Container(
              child:
              IconButton(
                iconSize: 50,
                icon: Icon(Icons.local_see),
                onPressed:(){
                  print(
                      "data from doneTasksList ${doneTasksList.length}");
                  // print( "data from doneTasksList ${doneTasksList[7]['TITLE']}");

                },
              ),




            ),
*/

          ],
        ),
      ),





    );
  }
}
