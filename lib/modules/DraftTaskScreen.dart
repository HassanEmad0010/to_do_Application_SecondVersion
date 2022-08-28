import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_application/shared/componant/DataBaseClass.dart';

import '../shared/componant/componant.dart';

class DraftTaskScreen extends StatefulWidget {
  @override
  State<DraftTaskScreen> createState() => _DraftTaskScreenState();
}

class _DraftTaskScreenState extends State<DraftTaskScreen> {
  SqlDb dbObject = new SqlDb();
  List draftTasksList = [];
  bool isLoading = true;
  var draftTaskScaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Map>> readDataMethod() async {
    List<Map> response =
        await dbObject.readData(sqlCommand: "SELECT * FROM 'DraftTASKS'");
    draftTasksList.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
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
      key: draftTaskScaffoldKey,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                value: 60,
                color: Colors.white,
              ),
            )
          : Container(
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
                      itemCount: draftTasksList.length,
                      itemBuilder: (context, index) {
                        return cardBuilder(
                            snapTitle: draftTasksList[index]['TITLE'],
                            snapDate: draftTasksList[index]['DATE'],
                            snapStatus: draftTasksList[index]['STATUS'],
                            snapTime: draftTasksList[index]['TIME'],
                            PressFunction: () async {
                              print("long pressed");
                              print("snap" + draftTasksList.toString());

                              await dbObject.insertData(
                                tableName: 'TASKS',
                                title: draftTasksList[index]['TITLE'],
                                date: draftTasksList[index]['DATE'],
                                time: draftTasksList[index]['TIME'],
                                status: "Idle",
                              );

                              int resp = await dbObject.DeleteData(
                                rowData: draftTasksList[index]['TITLE'],
                                tableName: 'DraftTASKS',
                              );

                              if (resp > 0) {
                                setState(() {});
                                draftTasksList.removeWhere((element) =>
                                    element['id'] ==
                                    draftTasksList[index]['id']);
                              }
                            }, longPressFunction: () {  });
                      }),
               /*   Container(
                    child: IconButton(
                      iconSize: 50,
                      icon: Icon(Icons.local_see),
                      onPressed: () {
                        print(
                            "data from draftTasksList ${draftTasksList.length}");
                        // print( "data from draftTasksList ${draftTasksList[7]['TITLE']}");
                      },
                    ),
                  ),*/
                ],
              ),
            ),
    );
  }
}
