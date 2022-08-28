import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

Widget textFormField({
  required TextEditingController textEditingController,
  TextInputType textInputType = TextInputType.emailAddress,
  //bool isPassword = false,
  String formFieldText = "Your Data",
  required String? Function(String? value) validator,
  required Function() onTabFunction,
  Function()? suffixFunction,
  IconData? iconPrefix,
  IconData? iconSuffix,
  Color color = Colors.black54,
  double width = double.infinity,
  double height = 80,
}) =>
    Container(
      decoration: BoxDecoration(border: Border.all(color: color, width: 3)),
      width: width,
      height: height,
      child: TextFormField(
        onTap: onTabFunction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefix: Icon(iconPrefix),
          suffix: IconButton(onPressed: suffixFunction, icon: Icon(iconSuffix)),
          labelText: formFieldText,

          //floatingLabelAlignment: FloatingLabelAlignment.center,
        ),
        controller: textEditingController,
        keyboardType: textInputType,
        validator: validator,
      ),
    );

Widget cardBuilder({
  //required AsyncSnapshot snapshot,
  required String snapTitle,
  required String snapDate,
  required String snapTime,
  required String snapStatus,
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 15),
  required Function() longPressFunction,
  Color color = Colors.green,
}) {
  return Container(
    decoration: BoxDecoration(
      // shape: BoxShape.circle,
      border: Border.all(color: Colors.black, width: 4),
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
      color: color,
    ),
    width: 100,
    height: 80,

    child: ListTile(
      /*textColor: Colors.teal,
        hoverColor: Colors.lightBlue,
        tileColor: Colors.red,*/
      selected: true,
      title: Text(
        snapDate,
        style: textStyle,
      ),
      leading: Text(snapTitle, style: textStyle),
      subtitle: Text(snapTime, style: textStyle),
      trailing: Text(snapStatus, style: textStyle),
      onTap: longPressFunction,

      //onLongPress:

      selectedTileColor: Colors.deepPurple,
      selectedColor: Colors.red,
    ),

    //Text(snapTitle,style: TextStyle(color: Colors.white,fontSize: 20),),
  );
}
