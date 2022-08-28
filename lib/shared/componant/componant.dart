import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';



Widget textFormField({
  required TextEditingController textEditingController,
  TextInputType textInputType = TextInputType.text,
  //bool isPassword = false,
  String formFieldText = "Your Data",
  required String? Function(String? value) validator,
  required Function() onTabFunction,
  Function()? suffixFunction,
  IconData? iconPrefix,
  IconData? iconSuffix,
  Color color = Colors.white,
  double width = double.infinity,
  double height = 80,
}) =>
    Container(
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 6),
        gradient:  const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.9, 1),
          colors: <Color>[
            Colors.green,
            Colors.greenAccent,
            Colors.teal,

          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),

      ),

      width: width,
      height: height,
      child: TextFormField(
        textAlign: TextAlign.center,
        onTap: onTabFunction,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefix: Icon(iconPrefix),
          suffix: IconButton(onPressed: suffixFunction, icon: Icon(iconSuffix)),
          labelText: formFieldText,
          fillColor: Colors.green,
        hoverColor: Colors.green,
          iconColor: Colors.blue,
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
  IconData icon = Icons.done,
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 15),
  required Function() PressFunction,
  required Function() longPressFunction,
  Color color = Colors.green,
}) {
  return


    Container(

      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 4),
        borderRadius: const BorderRadius.all(
          Radius.circular(14.0),
        ),
        color: color,
        gradient:  const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Colors.teal,
            //Colors.indigo,
            Colors.lightBlue,


          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),

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
        dense: true,
        leading: Text(snapTitle, style: textStyle),
        subtitle: Text(snapTime, style: textStyle),
        //trailing: Text(snapStatus, style: textStyle),
        trailing:  IconButton(icon: Icon(icon), onPressed: PressFunction,),

        onLongPress:longPressFunction,

        selectedTileColor: Colors.white,
        selectedColor: Colors.white,
      ),

      //Text(snapTitle,style: TextStyle(color: Colors.white,fontSize: 20),),
    );






  ;
}
