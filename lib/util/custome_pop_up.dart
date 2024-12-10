import 'package:flutter/material.dart';

void successPOP({
  required String content,
  required BuildContext context,


}){
   showDialog(context: context, builder: (context){
    return AlertDialog(
      content: Text(content),
    );
  });

}



void snackMessanger({
  required String content,
  required BuildContext context,


}){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$content'
          ),
      duration: Duration(seconds: 2),
    ),
  );

}